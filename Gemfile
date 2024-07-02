source "https://rubygems.org"

ruby "3.3.3"

gem "rails"

gem "bootsnap", require: false
gem "config"
gem "devise"
gem "importmap-rails"
gem "propshaft"
gem "pg"
gem "phlex-rails"
gem "packs-rails"
gem "puma"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "dockerfile-rails"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "hotwire-livereload"
  gem "rufo"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "cuprite"
  gem "simplecov", require: false
end
