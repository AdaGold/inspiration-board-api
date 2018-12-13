Rails.application.routes.draw do
  root to: 'boards#root'

  resources :boards, except: [:edit, :new, :destroy], param: :name do
    resources :cards, only: [:index, :create]
  end

  resources :cards, only: [:show, :update, :destroy]
end
