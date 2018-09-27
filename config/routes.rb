Rails.application.routes.draw do
  namespace 'api' do
    scope module: :v1 do
      resources :posts, only: %i[index create]
      post 'rate/(:id)', to: 'posts#rate', as: 'rate'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
