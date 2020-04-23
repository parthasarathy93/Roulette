Rails.application.routes.draw do
  resources :game_histories
  resources :games
  resources :dealers
  resources :casinos do
  	member do
  		put :recharge
  	end
  	resources :dealers, only: [:index, :create]
  end
   
  resources :dealers, only:[:start,:stop,:throw] do
     member do
  		put :start
  		put :stop
  		put :throw
  	end

  end

  resources :users do
  	  member do
  		put :enter
  		get :games
  		get :cashout
  		put :recharge
  	end
  	resources :bets
  end

 root 'casinos#index'



end
