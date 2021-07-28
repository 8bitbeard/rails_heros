source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.7.3'

gem 'rails', '~> 6.1.4'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "active_model_serializers", "~> 0.10.12"
gem 'rubocop', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "faker", "~> 2.18"
  gem 'sqlite3', '~> 1.4'
  gem "rspec-rails", "~> 5.0"
end

group :development do
end

group :test do
  gem "shoulda-matchers", "~> 5.0"
  gem "simplecov", "~> 0.21.2", require: false
end

group :production do
  gem "pg", "~> 1.2"
end
