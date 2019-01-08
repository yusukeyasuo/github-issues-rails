Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "repositories#index"
  resources :repositories
  resources :issues

  get 'repositories/:id/issues', to: 'repositories#reload', as: :repository_issues
end
