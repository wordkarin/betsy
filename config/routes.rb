Rails.application.routes.draw do

  root 'main#index'

  get "/auth/:provider/callback" => "sessions#create"

  get "/sessions/login_failure", to: "sessions#login_failure", as: "login_failure"
  get "/sessions", to: "sessions#index", as: "sessions"
  delete "/sessions", to: "sessions#destroy"

  resources :merchants, except: [:destroy] do
	   resources :products, only: [:new, :create, :index]
  end
  #add non-restful route orders where merchant id

  resources :products, except: [:new, :create, :destroy] do
  	resources :reviews, except: [:update, :destroy, :edit]
    resources :product_categories, only: [:new]
    resources :orders, only: [:create]
    resources :order_items, only: [:create]
  end
  patch 'products/:id/retired', to: 'products#retired', as: 'product_retired'


  resources :categories, except: [:destroy, :edit, :update]

  resources :orders, except: [:destroy, :index, :new, :create]

  # post 'products/:id/orders', to: 'orders#create'

  patch 'orders/:id/completed', to: 'orders#completed', as: 'order_completed'
  patch 'orders/:id/cancelled', to: 'orders#cancelled', as: 'order_cancelled'
  patch 'orders/:id/paid', to: 'orders#paid', as: 'order_paid'


  # RELATIONSHIP TABLE ROUTES
  resources :order_items, only: [:destroy, :update]
  patch 'order_items/:id/shipped', to: 'order_items#shipped', as: 'order_items_shipped'


  resources :product_categories, only: [:create, :destroy]

end
