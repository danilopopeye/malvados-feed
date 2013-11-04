require 'spec_helper'

describe StripBuilder do
  subject { described_class.new }

  describe :exists? do
    it 'should return true when exists a strip with this number' do
      create :strip, number: 1
      subject.exists?(1).should be_true
    end

    it 'should return false when do not exists a strip with this number' do
      subject.exists?(1).should be_false
    end
  end

  describe :latest do
    before do
      latest = File.new Rails.root.join 'spec/fixtures/latest.html'
      stub_request(:get, 'www.malvados.com.br').to_return(body: latest, status: 200)
    end

    it 'should return the latest strip number' do
      subject.latest.should eq 666
    end
  end

  describe :previous do
    it 'should return the previous strip number' do
      create :strip, number: 666
      subject.previous(666).should == 665
    end

    context :exceptions do
      it 'TODO: remember which strip has the wrong latest'
    end
  end

  describe :build do
    let(:base_url){ subject.settings[:base_url] }
    let(:strip){ subject.build number }
    let(:modified){ Time.now.utc }
    let(:number){ 666 }

    context "should create a strip with parsed content with" do
      before do
        stub_strip number, 'index_with_header', modified
      end

      it(:number){ strip[:number].should eq 666 }
      it(:previous){ strip[:previous].should eq 665 }
      it(:updated_at){ strip[:updated_at].equal? modified }
      it(:header){ strip[:header].should eq "#{base_url}logo#{number}.gif" }
      it(:image){ strip[:image].should eq "#{base_url}tirinha#{number}.gif" }
    end

    context 'exeptions' do
      it 'should handle not have a header image' do
        stub_strip number, 'index_without_header', modified
        strip[:header].should be_nil
      end

      it 'should have different url when number is 123' do
        stub_strip 123, 'index_with_header', modified, 'htm'
        subject.build 123
        WebMock.should have_requested(:get, "#{base_url}index123.htm")
      end
    end
  end

  private

  def stub_strip number, fixture, modified_date, extension = 'html'
    body = File.new Rails.root.join "spec/fixtures/#{fixture}.html"
    stub_request(:get, "http://www.malvados.com.br/index#{number}.#{extension}")
      .to_return(body: body, status: 200, header: { last_modified: modified_date })
  end
end
