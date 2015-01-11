Rails.application.routes.draw do
  resources :users, except: [:destroy, :index]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: :new
  end

  resources :posts, except: [:new, :index, :destroy] do
    resources :comments, only: :new
    post "upvote"
    post "downvote"
  end

  resources :comments, only: [:create, :show] do
    post "upvote"
    post "downvote"
  end

  root "sessions#new"
end
