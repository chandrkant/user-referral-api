Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts
      get "/user" => "users#show"
      post "/send_user_referral"=>"users#send_user_referral"
    end
  end
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             },defaults: { format: :json }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
