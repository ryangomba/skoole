namespace :tests do
    
    task :googlebooks => :environment do
        'cd #{Rails.root} && ruby -Itest test/unit/book_test.rb -n test_googlebooks'
    end
    
end