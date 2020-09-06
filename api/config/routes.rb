Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    collection do
      post :wx_login
      post :update_profile
      post :favorite
      post :un_favorite
    end
  end
end
