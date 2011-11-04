namespace :populate do
	desc "Populate database with phone numbers"
	task :numbers =>:environment do
		Number.create(:number => 12064532171)
		Number.create(:number => 12067927926)
		Number.create(:number => 13038000261)
		Number.create(:number => 14049630864)
		Number.create(:number => 14082159260)
		Number.create(:number => 17202531114)
		Number.create(:number => 18167590782)
		Number.create(:number => 18167590784)
		Number.create(:number => 19252700851)
		Number.create(:number => 19252700853)
	end
end