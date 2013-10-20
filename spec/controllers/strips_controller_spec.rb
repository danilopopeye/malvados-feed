require 'spec_helper'

describe StripsController do
  render_views

  before do
    3.times { create :strip }
  end

  describe "GET '/strips.atom'" do
    before do
      get 'show', :format => :atom
    end

    it "should show the atom feed" do
      response.should be_valid_atom
    end

    it 'should render all strips' do
      assigns(:strips).count.should eq 3
    end
  end

  describe "GET '/strips/latest.atom'" do
    before do
      get 'show', :format => :atom, :latest => true
    end

    it "should show the atom feed" do
      response.should be_valid_atom
    end

    it 'should render only the latest strip' do
      assigns(:strips).count.should eq 1
      assigns(:strips).should == [ Strip.latest ]
    end
  end

end
