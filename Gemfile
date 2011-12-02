source :rubygems

if RUBY_VERSION =~ /1.9/
	Encoding.default_external = Encoding::UTF_8
	Encoding.default_internal = Encoding::UTF_8
end

##### BASE #####

gem 'rails', '3.1.0'
gem 'jquery-rails'
gem "rspec"
gem 'json'

group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

##### AUTH #####

gem 'omniauth', '1.0.0'
gem 'omniauth-facebook', '1.0.0'

##### HTTP #####

gem 'httparty'
gem 'delayed_job'

##### JAVASCRIPT #####

gem 'execjs'
gem 'therubyracer'

##### DEVELOPMENT #####

group :development, :staging do
    gem 'sqlite3'
    gem 'heroku'
end

##### PRODUCTION #####

group :production do
    gem 'pg'
    gem 'thin'
end

