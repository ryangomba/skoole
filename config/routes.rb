Skoole::Application.routes.draw do

    # AUTH
    
    match '/autologin' => 'site#autologin'
    match '/login' => 'site#login'
    match '/logout' => 'site#logout'
    match '/auth/:provider/callback' => 'users#create'
    match '/auth/failure' => 'site#welcome'
    match '/user/update' => 'users#update'

    # SITE

    root to: 'site#welcome'
    resources :listings
    resources :buy_listings, :controller => :listings, :listing_type => 'BuyListing'
    resources :sell_listings, :controller => :listings, :listing_type => 'SellListing'
    match 'matches' => 'users#show'

    # CALLBACKS
    
    match 'in' => 'messages#in'
    
    # TESTS
    
    match 'out' => 'messages#out'

end
