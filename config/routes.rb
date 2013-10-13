MalvadosFeed::Application.routes.draw do
  resource :strips, only: :show
  root 'site#index'
end
