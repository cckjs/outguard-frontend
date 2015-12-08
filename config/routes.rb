Rails.application.routes.draw do

  resources :url_weight_rules
  resources :filter_words
  resources :wx_documents

  resources :bd_documents do
    get 'search', on: :collection
  end

  resources :web_pages

  resources :apps do
    get 'docs', on: :collection
    get 'my_docs', on: :collection
    get 'npy_docs', on: :collection
    get 'add_my_doc', on: :collection
    get 'remove_my_doc', on: :collection
  end

  root to: "apps#index"

end
