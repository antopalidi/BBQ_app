source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.1.1'

gem 'rails', '~> 7.0.2', '>= 7.0.2.4'

gem 'devise'

gem 'devise-i18n'
gem 'rails-i18n'

gem 'geocoder'
gem 'gmaps4rails'

gem 'carrierwave'
gem 'rmagick'
gem 'fog-aws'

gem 'dotenv-rails'
gem 'mailjet'

gem 'lightbox2-rails'

gem 'sprockets-rails'
gem 'puma', '~> 5.0'
gem 'jsbundling-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'cssbundling-rails'
gem 'jbuilder'
gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem 'web-console'
  gem 'sqlite3', '~> 1.4'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'pg'
end
