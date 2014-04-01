Rails.application.routes.draw do
  resources :projects do
    resources :groups
  end
end