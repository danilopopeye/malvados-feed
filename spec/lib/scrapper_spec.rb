require 'spec_helper'

describe Scrapper do
  before do
    StripBuilder.any_instance.stub({
      latest: 666, previous: 0
    })
  end

  describe :latest do
    after { subject.latest }

    context 'should call #scrap with latest strip' do
      before do
        subject.should_receive(:scrap).with(666) { scrap_result }
      end

      context 'if success' do
        let(:scrap_result) { true }
        let(:strip) { build(:strip) }

        it 'cache the strip' do
          Strip.stub(find_by: strip)
          Rails.cache.should_receive(:write).with('strip#latest', strip)
        end
      end

      context 'if fails' do
        let(:scrap_result) { false }

        it 'do not cache it' do
          Rails.cache.should_not_receive(:write)
        end
      end
    end
  end

  describe :all do
    after { subject.all }

    it 'should parse the strips in sequence' do
      subject.should_receive(:scrap).with(666)
    end

    it 'should stop in the first strip' do
      subject.should_receive(:scrap).once
    end

    it 'should parse each strip only once' do
      create :strip, number: 666
      Strip.any_instance.should_not_receive(:save)
    end
  end
end
