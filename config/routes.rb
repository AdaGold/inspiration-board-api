Rails.application.routes.draw do
  resources :boards, except: [:edit, :new, :destroy], param: :name do
    resources :cards, only: [:index, :create]
  end

  resources :cards, only: [:show, :update, :destroy]
end
