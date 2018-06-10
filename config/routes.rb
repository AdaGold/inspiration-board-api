Rails.application.routes.draw do

  resources :boards, except: [:edit, :new], param: :name do
    resources :cards, except: [:edit, :new]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
