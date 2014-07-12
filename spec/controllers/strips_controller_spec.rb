require 'spec_helper'

describe StripsController do
  render_views

  before do
    4.times { create :strip }
    create :strip, number: 666
  end

  describe "GET '/strips.atom'" do
    before do
      get :show, format: :atom
    end

    it 'should set the cache headers to 1h' do
      response.headers['Cache-Control'].should eq('max-age=3600, public')
    end

    it "should show the atom feed" do
      response.should be_valid_atom
    end

    it 'should render all strips' do
      assigns(:strips).count.should eq(5)
    end
  end

  describe "GET '/strips/latest.atom'" do
    before do
      get :show, format: :atom, latest: true
    end

    it 'should set the cache headers to 1h' do
      response.headers['Cache-Control'].should eq('max-age=3600, public')
    end

    it "should show the atom feed" do
      response.should be_valid_atom
    end

    it 'should render only the latest strip' do
      assigns(:strips).count.should eq 1
      assigns(:strips).map(&:number).should eq([666])
    end
  end

end
