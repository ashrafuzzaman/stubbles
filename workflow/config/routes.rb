Rails.application.routes.draw do
  resources :story_types, only: [] do
    resources :workflow_statuses
    resources :workflow_transitions
  end
end