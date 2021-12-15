Rails.application.routes.draw do
  devise_for :users

  get 'home/index'
  root 'home/index', controller: :home, action: :index

  resource :user, controller: :user, only: :show do
    member do
      get :play_game
      get :purchase_items
    end
  end
end
