require 'spec_helper'

describe Scrapper do
  subject { described_class.new }
  let!(:base_url){ subject.url }

  its(:url){ should match %r{www.malvados.com.br} }

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
    it 'should call #scrap with latest strip' do
      subject.stub get_latest: 666
      subject.should_receive(:scrap).with 666
      subject.latest
    end
  end

  describe :get_number do
    it 'should parse the number from strip link' do
      subject.get_number('index666.html').should == 666
    end
  end

  describe :get_latest do
    before do
      latest = File.new Rails.root.join 'spec/fixtures/latest.html'
      stub_request(:get, 'www.malvados.com.br').to_return(body: latest, status: 200)
    end

    it 'should return the latest strip number' do
      subject.get_latest.should == 666
    end
  end

  describe :get_previous do
    it 'should return the previous strip number' do
      create :strip, number: 666
      subject.get_previous(666).should == 665
    end
  end

  describe :build_strip_url do
    it 'should generate the correct strip url' do
      subject.build_strip_url(666).should == base_url + 'index666.html'
    end

    it 'should generate the correct url for strip 123' do
      subject.build_strip_url(123).should == base_url + 'index123.htm'
    end
  end

  describe :build_strip_image do
    let(:image){ 'image.ext' }

    it 'should generate the correct url for relative path' do
      subject.build_strip_image(image).should == base_url + image
    end

    it 'should return the same url when is a full url' do
      host = 'http://host/image.ext'
      subject.build_strip_image(host).should == host
    end
  end

  describe :get_and_parse do
    # FIXME: should change to subject but nedd before to have been called
    let(:strip){ Strip.find_by number: number }
    let(:modified){ Time.now.utc }
    let(:number){ 666 }

    before do
      stub_strip number, 'index_with_header', modified
      described_class.new.get_and_parse number
    end

    context "should create a strip with parsed content with" do
      it(:number){ strip[:number].should == 666 }
      it(:previous){ strip[:previous].should == 665 }
      it(:updated_at){ strip[:updated_at].equal? modified }
      it(:header){ strip[:header].should == "#{base_url}logo#{number}.gif" }
      it(:image){ strip[:image].should == "#{base_url}tirinha#{number}.gif" }
    end

    context 'exeptions' do
      let(:strip){ Strip.find_by number: 1 }

      before do
        stub_strip 1, 'index_without_header', modified
        described_class.new.get_and_parse 1
      end

      it ':header should be nil when strip does not have one' do
        strip.header.should be_nil
      end

      it 'should set :previous to zero for strip number 1' do
        strip[:previous].should == 0
      end
    end
  end

  describe :all do
    before do
      subject.stub get_latest: 1
      subject.stub get_previous: 0
    end

    it 'should parse the strips in sequence' do
      subject.should_receive(:scrap).with 1
      subject.all
    end

    it 'should stop in the first strip' do
      subject.should_receive(:scrap).once
      subject.all
    end
  end

  private

  def stub_strip number, fixture, modified_date
    latest = File.new Rails.root.join "spec/fixtures/#{fixture}.html"
    stub_request(:get, "http://www.malvados.com.br/index#{number}.html").to_return(body: latest, status: 200, header: { last_modified: modified_date })
  end
end
