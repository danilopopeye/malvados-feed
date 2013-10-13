require 'spec_helper'

describe StripsController do
  before do
    create :strip
  end

  describe "GET 'show'" do
    it "should be a redirect" do
      get 'show'
      response.code.should == '302'
    end
  end

  describe "GET 'show.atom'" do
    render_views

    it "should show the atom feed" do
      get 'show', format: :atom
      response.should be_valid_atom
    end
  end

end
