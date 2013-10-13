require 'spec_helper'

describe 'routes' do
  it 'application root should route to site#index' do
    { :get => root_path }.should route_to(:controller => 'site', :action => 'index')
  end
end
