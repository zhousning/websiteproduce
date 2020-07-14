Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  devise_scope :user do
    get 'forget', to: 'users/passwords#forget'
    patch 'update_password', to: 'users/passwords#update_password'
  end

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :controls, :only => [:index]
  resources :templates do
    get :produce, :on => :member
  end

  resources :medical_subjects, :only => [:index]

  resources :nlps do
    collection do
      post 'analyze'
    end
  end

  resources :notices
  resources :articles do
    get :export, :on => :collection
    get :main_image, :on => :member
    get :detail_image, :on => :member
  end

  resources :websites do
    resources :documents do
      get :check, :on => :member
      get :download, :on => :member
      get :preview, :on => :member
    end
    resources :pages do
      get :set_parent, :on => :collection
    end
    get :export, :on => :member
  end

  resources :newsites do
    get :draft_navbar, :on => :member
    get :draft_edit, :on => :member
    put :draft_update, :on => :member
    patch :draft_update, :on => :member
    get :produce, :on => :member
    get :prepare, :on => :member
  end

  resources :ocrs do
    post :analyze, :on => :collection
  end

  resources :subunits

  resources :color_libraries
  resources :icon_libraries

  resources :navbars
  resources :formats
  resources :blocks
  resources :block_contents
  resources :carousels
  resources :title_ones
  resources :title_twos
  resources :title_threes

  resources :statistics, :only => [:index] do
    get :line, :on => :collection
    get :series, :on => :collection
    get :column, :on => :collection
    get :pie, :on => :collection
    get :bar, :on => :collection
    get :area, :on => :collection
    get :scatter, :on => :collection
  end

  resources :systems, :only => [] do
    get :send_confirm_code, :on => :collection
  end

  resources :users, :only => []  do
    get :center, :on => :collection
    get :alipay_return, :on => :collection
    post :alipay_notify, :on => :collection
    get :mobile_authc_new, :on => :member
    post :mobile_authc_create, :on => :member
    get :mobile_authc_status, :on => :member
  end

  resources :orders, :only => [:new, :create] do
    get :pay, :on => :collection
    get :alipay_return, :on => :collection
    post :alipay_notify, :on => :collection
  end

  resources :tasks, :only => [] do
    get :invite, :on => :collection
  end

  resources :accounts, :only => [:edit, :update] do
    get :recharge, :on => :collection 
    get :info, :on => :collection
    get :status, :on => :collection
  end

  resources :roles

  resources :spiders do
    get :start, :on => :member
  end
  resources :selectors

  root :to => 'home#index'
end
