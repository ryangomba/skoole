namespace :populate do
    
	desc "Populate database with phone numbers"
	task :numbers => :environment do
		#Number.create(:number => 12064532171, :index => 0)
		#Number.create(:number => 12067927926, :index => 1)
		#Number.create(:number => 13038000261, :index => 2)
		#Number.create(:number => 14049630864, :index => 3)
		#Number.create(:number => 14082159260, :index => 4)
		#Number.create(:number => 17202531114, :index => 5)
		#Number.create(:number => 18167590782, :index => 6)
		#Number.create(:number => 18167590784, :index => 7)
		#Number.create(:number => 19252700851, :index => 8)
		#Number.create(:number => 19252700853, :index => 9)
		Number.create(:number => 14049961853, :index => 0)
		Number.create(:number => 14049961820, :index => 1)
		Number.create(:number => 14049961848, :index => 2)
		Number.create(:number => 14049961813, :index => 3)
		Number.create(:number => 14049961827, :index => 4)
		Number.create(:number => 14049961858, :index => 5)
		Number.create(:number => 14049204794, :index => 6)
		Number.create(:number => 14049639581, :index => 7)
		Number.create(:number => 14043488563, :index => 8)
		Number.create(:number => 14044482984, :index => 9)
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
    task :books => :environment do
        School.create(
            name: "Georgia Tech",
            url: 'http://gatech.edu',
            domain: 'gatech'
        )
    end
	
end