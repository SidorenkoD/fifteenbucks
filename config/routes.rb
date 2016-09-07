Rails.application.routes.draw do
  root 'admin/dashboard#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
