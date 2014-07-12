require 'spec_helper'

describe Scrapper do
  before do
    StripBuilder.any_instance.stub({
      latest: 666, previous: 0
    })
  end

  describe :latest do
    it 'should call #scrap with latest strip' do
      subject.should_receive(:scrap).with 666
      subject.latest
    end
  end

  describe :all do
    it 'should parse the strips in sequence' do
      subject.should_receive(:scrap).with 666
      subject.all
    end

    it 'should stop in the first strip' do
      subject.should_receive(:scrap).once
      subject.all
    end

    it 'should parse each strip only once' do
      create :strip, number: 666
      Strip.any_instance.should_not_receive :save
      subject.all
    end
  end
end
