require 'spec_helper'

describe 'routes' do
  let(:strip_route) do
    { :controller => 'strips', :action => 'show', :format => :atom }
  end

  it 'application root should route to site#index' do
    { :get => root_path }.should route_to :controller => 'site', :action => 'index'
  end

  it '/strips should route to strips#show' do
    { :get => strips_path }.should route_to strip_route
  end

  it '/strips/latest should route to strips#show params[:latest]' do
    strip_route.merge!({ :latest => true })
    { :get => latest_strips_path }.should route_to strip_route
  end
end
