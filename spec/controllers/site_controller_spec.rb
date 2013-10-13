require 'spec_helper'

describe SiteController do
  describe "GET 'index'" do
    it "returns http success" do
      create :strip
      get 'index'
      response.should be_success
    end

    context 'assigns' do
      let!(:strip){ create :strip }

      it '@latest' do
        get 'index'
        assigns(:latest).should == strip
      end

      it '@count' do
        get 'index'
        assigns(:count).should == 1
      end
    end
  end
end
