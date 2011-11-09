Skoole::Application.routes.draw do

    # AUTH
    
    match '/autologin' => 'site#autologin'
    match '/login' => 'site#login'
    match '/logout' => 'site#logout'
    match '/auth/:provider/callback' => 'users#create'

    # SITE

    root :to => 'site#welcome'
    resources :listings
    match 'matches' => 'users#show'

    # CALLBACKS
    
    match 'in' => 'messages#in'
    
    # TESTS
    
    match 'out' => 'messages#out'

end
