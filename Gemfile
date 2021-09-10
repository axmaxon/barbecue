source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'devise', '~> 4.7', '>= 4.7.3'
gem 'devise-i18n'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.7'
gem 'mailjet'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'rails-i18n', '~> 6.0.0'
gem 'russian'
gem 'webpacker', '~> 5.0'

# Для загрузки файлов
gem 'carrierwave'
# Для обработки изображений
gem 'rmagick'
# Для работы с AWS
gem 'fog-aws'
# Для создания системы авторизации
gem 'pundit'
# Для авторизации через соцсети
gem 'omniauth'
gem 'omniauth-facebook'
gem "omniauth-rails_csrf_protection"

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capistrano', '~> 3.16'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'factory_bot_rails'
  gem 'letter_opener'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'rubocop', '~> 1.19', require: false
  gem 'rubocop-performance', '~> 1.11', require: false
  gem 'rubocop-rails', '~> 2.11', require: false
end
