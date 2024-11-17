source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 7.2.2"
gem "sprockets-rails"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "bcrypt", "~> 3.1.7"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "bootstrap", "~> 5.3", ">= 5.3.3"
gem "sassc-rails", "~> 2.1", ">= 2.1.2"
gem "rack-cors", "~> 2.0"
gem "jwt", "~> 2.9"
gem "active_model_serializers", "~> 0.10.14"

group :development, :test do
  gem "dotenv-rails", "~> 3.1", ">= 3.1.4"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rspec-rails", "~> 7.0", ">= 7.0.1"
  gem "shoulda-matchers", "~> 6.4"
  gem "factory_bot_rails", "~> 6.4", ">= 6.4.3"
  gem "rubocop-rails-omakase", require: false
  gem "foreman", "~> 0.88.1"
  gem "faker", "~> 3.5"
end

group :development do
  gem "web-console"
end
