Skoole::Application.routes.draw do

    # AUTH
    
    match '/connect' => 'users#connect'
    match '/auth/:provider/callback' => 'users#callback'
    match '/authorized' => 'users#authorized'
    match '/auth/failure' => 'site#welcome'
    match '/logout' => 'users#logout'

    # SITE

    root to: 'site#welcome'
    
    resources :books
    resources :listings
    resources :buy_listings, :controller => :listings, :listing_type => 'BuyListing'
    resources :sell_listings, :controller => :listings, :listing_type => 'SellListing'
    
    resources :users
    match 'matches' => 'users#show'
    match 'poll_listings' => 'listings#poll'

    # CALLBACKS
    
    match 'twilio/sms' => 'messages#twilio_sms'
    match 'twilio/voice' => 'messages#twilio_voice'
    
    match 'sms_in' => 'messages#nexmo_sms'
    match 'email_in' => 'messages#sendgrid_email'

end
