Rails.application.routes.draw do
  get root to: redirect('/api/posts')
  namespace 'api' do
    scope module: :v1 do
      resources :posts, only: %i[index create]
      post 'rate/(:post_id)', to: 'ratings#rate', as: 'rate'
      namespace :users do
        get 'list_trolls'
      end
    end
  end
  get '/500', to: 'errors#internal_error'
  get '/404', to: 'errors#not_found'
end
