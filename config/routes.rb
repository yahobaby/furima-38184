Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do 
    # 7つのアクションを全部使う為、"only: [:index, :new, :create, :show, :update, :edit, :destroy]"の記述は不要
    resources :orders, only: [:index, :create]
    # items/各自itemのid/ordersへルートさせる為
  end
end
