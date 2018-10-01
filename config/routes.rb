Rails.application.routes.draw do
  namespace 'api' do
    scope module: :v1 do
      resources :posts, only: %i[index create]
      post 'rate/(:post_id)', to: 'ratings#rate', as: 'rate'
      namespace :users do
        get 'list_trolls'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
