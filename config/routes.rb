Rails.application.routes.draw do
  root 'home#home'

  resources :potions

  resources :ingredients
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
	#ajax
	get '/potions/ajax/get_new_price', to: 'potions#get_new_price'

end
