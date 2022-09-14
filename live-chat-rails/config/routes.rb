Rails.application.routes.draw do
  constraints format: :json do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'auth/registrations'
    }
    resources :rooms, only: %i[index show create destroy] do
      resources :messages, only: %i[index]
    end
    resources :messages, only: %i[index destroy] do
      resources :likes, only: ['create']
    end
    resources :likes, only: ['destroy']
  end
end
