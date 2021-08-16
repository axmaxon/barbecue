source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'puma', '~> 5.0'
gem 'webpacker', '~> 5.0'
gem 'jbuilder', '~> 2.7'
gem 'devise', '~> 4.7', '>= 4.7.3'
gem 'devise-i18n'
gem 'russian'
gem 'rails-i18n' ,  '~> 6.0.0'
gem 'mailjet'
gem 'dotenv-rails'

# Для загрузки файлов
gem 'carrierwave'
# Для обработки изображений
gem 'rmagick'
# Для работы с AWS
gem 'fog-aws'
# Для создания системы авторизации
gem 'pundit'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3', '~> 1.4'
  gem 'letter_opener'
  gem "capistrano", "~> 3.16"
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'factory_bot_rails'
end
