Rails.application.routes.draw do
  devise_for :users

  root 'events#index'

  resources :events do
    # Вложенные ресурсы комментариев, подписок, фотографий
    resources :comments, only: %i[create destroy]
    resources :subscriptions, only: %i[create destroy]
    resources :photos, only: %i[create destroy]

    # Возможность передать POST-запрос по уже существующему адресу: events/show (юзер
    # передает пин-код)
    post :show, on: :member
  end

  resources :users, only: %i[show edit update]
end
