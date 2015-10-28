Rails.application.routes.draw do

  resources :wx_documents

  resources :bd_documents do
    get 'search', on: :collection
  end

  root to:  "wx_documents#index"

end
