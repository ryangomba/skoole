namespace :populate do
    
	desc "Populate database with phone numbers"
	task :numbers => :environment do
	    if Rails.env == :production
	        nums = [
	            14049961853, 14049961820,
	            14049961848, 14049961813,
	            14049961827, 14049961858,
	            14049204794, 14049639581,
	            14043488563, 14044482984
	            ]
	    else
	        nums = [
	            14159686903, 14152374975,
	            14158136558, 14152370973,
	            14152370686, 14152266945,
	            14152370612, 14154844995,
	            14154844335, 14159443157
	            ]
	    end
	    nums.each_with_index do |n, i|
	        Number.create(:number => n, :index => i)
	    end
	end
	
	desc "Populate database with a few users"
	task :users => :environment do
	    User.create(
	        name: 'Ryan Gomba',
	        email: 'ryan@ryangomba.com',
	        sms: '18457026112',
	        provider: 'facebook',
	        uid: '779018113'
	    )
    end
    
    desc "Populate database with a book"
    task :books => :environment do
        Book.create(
            isbn: '9780061857638',
            title: 'Lost Memory of Skin',
            author: 'Russell Banks',
            thumbnail: 'http://bks8.books.google.com/books?id=Lut88YAqmkUC&printsec=frontcover&img=1&zoom=5&source=gbs_api',
            published: Time.new(2011,9,27).to_date
        )
    end
    
    desc "Populate database with schools"
    task :schools => :environment do
        School.create(
            name: "Georgia Tech",
            url: 'http://gatech.edu',
            domain: 'gatech'
        )
    end
	
end
