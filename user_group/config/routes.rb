Rails.application.routes.draw do
  resources :projects do
    resources :groups do
      collection do
        put :assign
      end
    end
  end
end