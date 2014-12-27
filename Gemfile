source 'http://rubygems.org'

gem 'rails', '~> 4.2.0'

gem 'jquery-rails'
gem 'sass-rails'
gem 'uglifier'

# Mongoid
gem 'mongoid'

#Heroku
gem 'unicorn', :platform => :ruby
gem 'rails_12factor', :group => :production # heroku fix

group :development, :test do
  gem 'did_you_mean' # Help getting names right and avoiding simple bugs
end

group :development do
  gem 'spring'
  gem 'nokogiri' # HTML parsing
  gem 'better_errors' # Better error stacktraces in browser
  gem 'binding_of_caller' # Enable inline debugging on browser errors page
  gem 'web-console', '~> 2.0' # Rails 4.2
end

gem 'kaminari'
gem 'chartkick'
