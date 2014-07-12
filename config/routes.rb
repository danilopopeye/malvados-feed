Rails.application.routes.draw do
  resource :strips, only: :show, :defaults => { :format => :atom } do
    get '/latest' => 'strips#show', :defaults => { :latest => true }, :path => 'latest'
  end
  root 'site#index'
end
