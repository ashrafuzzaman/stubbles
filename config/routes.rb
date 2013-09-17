Stubbles::Application.routes.draw do
  root :to => 'projects#index'

  devise_for :users

  resources :projects do
    resources :milestones

    resources :stories do #, :only => [:index, :show]
      member do
        put 'update_status'
      end
      collection do
        post 'update_scope_and_priority'
      end
    end
    resources :project_memberships do
      member do
        put 'update_role'
        put 'activate'
        put 'deactivate'
      end
    end
    member do
      post 'update_time_entry'
      get 'time_entry'
    end

    resources :project_reports do
      collection do
        get 'sprint_burndown'
      end
    end
  end

  resources :stories do
    resources :tasks do
      member do
        put 'update_status'
      end
    end
    resources :comments
  end

  get 'users/:id' => 'users#show', :as => 'user'
  get 'user/search' => 'users#search_new', :as => 'new_user_search'
  post 'user/search' => 'users#search', :as => 'user_search'
  match 'projects/:project_id/dashboard' => 'dashboard#index', :as => 'project_dashboard'
  match 'projects/:project_id/new_dashboard' => 'dashboard#new_index', :as => 'new_project_dashboard'

  match 'projects/:project_id/calendar' => 'story_calendar#index', :as => 'story_calendar'
  put 'projects/:project_id/stories/:id/start_at' => 'story_calendar#update_start_at'
  put 'projects/:project_id/stories/:id/complete_at' => 'story_calendar#update_complete_at'
  get 'projects/:project_id/calendar/story_feed' => 'story_calendar#story_feed'
end
