require 'spec_helper'

describe Strip do
  it { should be_a Mongoid::Document }
  it { should be_timestamped_document.with(:updated) }

  it { should have_field(:number).of_type(Integer) }
  it { should have_field(:previous).of_type(Integer)  }
  it { should have_field(:image).of_type(String)  }
  it { should have_field(:header).of_type(String)  }

  [ :number, :image, :previous ].each do |field|
    it { should validate_presence_of field }
  end

  [ :number, :previous ].each do |field|
    it { should validate_uniqueness_of field }
  end

  describe 'self.latest' do
    before do
      create :strip, number: 1
      create :strip, number: 666
    end

    it 'should return the Strip with the highest number' do
      Strip.latest[:number].should eq 666
    end
  end
end
