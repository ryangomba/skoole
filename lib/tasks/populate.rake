namespace :populate do
	desc "Populate database with phone numbers"
	task :numbers =>:environment do
		Number.create(:number => 12064532171, :index => 0)
		Number.create(:number => 12067927926, :index => 1)
		Number.create(:number => 13038000261, :index => 2)
		Number.create(:number => 14049630864, :index => 3)
		Number.create(:number => 14082159260, :index => 4)
		Number.create(:number => 17202531114, :index => 5)
		Number.create(:number => 18167590782, :index => 6)
		Number.create(:number => 18167590784, :index => 7)
		Number.create(:number => 19252700851, :index => 8)
		Number.create(:number => 19252700853, :index => 9)
	end
end