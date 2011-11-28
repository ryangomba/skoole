Skoole::Application.routes.draw do

    # AUTH
    
    match '/connect' => 'users#connect'
    match '/auth/:provider/callback' => 'users#callback'
    match '/authorized' => 'users#authorized'
    match '/auth/failure' => 'site#welcome'
    match '/logout' => 'users#logout'

    # SITE

    root to: 'site#welcome'
    
    resources :listings
    resources :buy_listings, :controller => :listings, :listing_type => 'BuyListing'
    resources :sell_listings, :controller => :listings, :listing_type => 'SellListing'
    
    resources :users
    match 'matches' => 'users#show'

    # CALLBACKS
    
    match 'in' => 'messages#in'
    
    # TESTS
    
    match 'out' => 'messages#out'

end
