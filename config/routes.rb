Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  resources :offers

  namespace 'api' do
    namespace 'v1' do
      resources :offers
    end
  end
end
