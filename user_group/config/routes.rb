Rails.application.routes.draw do
  resources :projects do
    resources :groups do
      collection do
        post :assign
      end
    end
  end
end