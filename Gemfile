source 'http://rubygems.org'

ruby '2.1.1'
gem 'rails', '~> 4.2.0'

gem 'jquery-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

gem 'mongoid'

#Heroku
gem 'unicorn', :platform => :ruby
gem 'rails_12factor', :group => :production # heroku fix

gem 'bootstrap-sass', '~> 3.3.1' # CSS framework
gem 'kaminari' # Pagination
gem 'chartkick' # Graphics

group :development, :test do
  gem 'did_you_mean' # Help getting names right and avoiding simple bugs
end

group :development do
  gem 'spring'
  gem 'quiet_assets' # Avoid assets logs in server
  gem 'better_errors' # Better error stacktraces in browser
  gem 'binding_of_caller' # Enable inline debugging on browser errors page
  gem 'web-console', '~> 2.0' # Rails 4.2
  
  gem 'nokogiri' # HTML parsing
end

