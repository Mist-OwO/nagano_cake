Rails.application.routes.draw do
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

scope module: :public do
  root to: 'homes#top'
  get 'about' => 'homes#about'
  resources :items, only: [:index, :show]
  resource :customer, only: [:show, :edit, :update] do
    collection do
      get :confirm_deleted
      patch :is_deleted
    end
  end
  resources :cart_items, only: [:index, :create, :update, :destroy] do
    delete 'destroy_all', on: :collection
  end
  resources :orders, only: [:new, :index, :create, :show] do
    collection do
      post :confirm
      get :confirm, to: redirect('orders/new')
      get :thanks
    end
  end
  resources :addresses, only: [:index, :create, :edit, :update, :destroy]
end

namespace :admin do
  root to: 'homes#top'
  resources :items, only: [:new, :index, :create, :show, :edit, :update]
  resources :genres, only: [:index, :create, :edit, :update, :destroy]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :orders, only: [:show, :update]
  resources :order_items, only: [:update]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end