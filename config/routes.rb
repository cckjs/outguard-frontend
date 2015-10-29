Rails.application.routes.draw do

  resources :wx_documents

  resources :bd_documents do
    get 'search', on: :collection
  end

  resources :web_pages

  root to:  "wx_documents#index"

end
