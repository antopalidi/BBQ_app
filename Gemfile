source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.1.1'

gem 'ed25519', '>= 1.2', '< 1.3'
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
gem 'rails', '~> 7.0.2', '>= 7.0.2.4'

gem 'devise'

gem 'devise-i18n'
gem 'rails-i18n'
gem 'pundit'

gem 'omniauth'
gem 'omniauth-facebook'

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

gem 'resque'
gem 'sidekiq'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem 'letter_opener'
  gem 'web-console'
  gem 'sqlite3', '~> 1.4'
  gem "capistrano"
  gem "capistrano-rails"
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-resque', require: false
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'pg'
end
