Rails.application.routes.draw do
  root "admin/backoffice#index"
  namespace :v1 do
    resources :exercises, only: [ :new, :index, :edit, :update, :show, :destroy, :create ]
    resources :workouts
  end

  resources :users, only: [ :create, :index ]
  get "/sign_in", to: "users#sign_in"
  post "/sign_in", to: "users#sign_in"
  delete "/sign_out", to: "sessions#destroy", as: :destroy_user_session

  direct :rails_blob do |blob|
    url_for(blob)
  end

  get "v1/videos/:filename", to: "redirect#video", as: "video_redirect"
  get "v1/images/:filename", to: "redirect#image", as: "image_redirect"
end
