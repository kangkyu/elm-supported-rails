Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope defaults: {format: :json} do
    get '/entries' => 'entries#index'
    get '/random-entries' => 'entries#random_entries'
  end
  root 'homepage#index'
end
