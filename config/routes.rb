Rails.application.routes.draw do

  devise_for :users

  root "events#index"

  resources :events do
    # Вложенные ресурсы комментариев, подписок, фотографий
    resources :comments, only: [:create, :destroy]
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]

    # Возможность передать POST-запрос по уже существующему адресу: events/show (юзер
    # передает пин-код)
    post :show, on: :member
  end

  resources :users, only: [:show, :edit, :update]
end
