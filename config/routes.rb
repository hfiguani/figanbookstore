Rails.application.routes.draw do


  resources :profiles
  root 'catalog#index'
  resources :catalog do
    get "/:book_id", to: 'catalog#show', as: 'book_show'
  end
  resource :admin do
    resources :books
    resources :categories
  end
  # get 'admin/books', to:'catalog#load_cart', as: 'admin_books'
  #get 'admin/Add/book', to:'catalog#load_cart', as: 'admin_add_book'
  #get 'admin/customers', to:'catalog#load_cart', as: 'admin_customers'
  #get 'admin/orders', to:'catalog#load_cart', as: 'admin_orders'
  #get 'admin/archive', to:'catalog#load_cart', as: 'admin_archive'
  get 'admin/unpublished_books', to:'books#unpublished',as: 'unpublished_books'
  get 'admin/unpublish_book/:id', to:'books#unpublish_book',as: 'unpublish_book'
  get 'admin/publish_book/:id', to:'books#publish_book', as: 'admin_publish_book'

  devise_for :users, path: '', # optional namespace or empty string for no space
             path_names: {
               new_user_session: 'login',
               sign_out: 'logout',
               password: 'secret',
               confirmation: 'verification',
               registration: 'register',
               sign_up: 'signup'
             } ,controllers: { registrations: "registrations" }
  resources :books do
    resources :reviews
  end
  delete '/cart/:deleted_book_cart', to:'catalog#remove_from_cart', as: 'remove_from_cart'
  delete '/:deleted_book_cart', to:'catalog#remove_from_cart', as: 'root_after_delete'
  get '/cart', to:'catalog#load_cart', as: 'user_cart'
  get '/:id', to:'catalog#add_book_cart', as: 'add_to_cart'
  get 'Account/orders', to:'catalog#orders', as: 'user_orders'
  get 'search/index', to: 'search#index', as: 'search_result'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
