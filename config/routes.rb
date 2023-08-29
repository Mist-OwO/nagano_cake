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

  namespace :admin do
    root to: 'homes#top'
    
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    
    resources :customers, only: [:index, :show, :edit, :update]
    
    resources :orders, only: [:show]
  end
  
  scope module: :public do
    root to: 'homes#top'
    
    get 'about' => 'homes#about'
    
    resources :items, only: [:index, :show]
    
    resources :customers, only: [:show, :update, :edit]
    get "/customers/unsubscribe" => "customers#unsubscribe"
    patch "/customers/withdraw" => "customers#withdraw"
        
    resources :cart_items do
      delete :destroy_all, on: :collection
    end
    
    resources :orders do
      post :check, on: :collection
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end