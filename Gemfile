source "https://rubygems.org"

ruby "3.3.3"

gem "rails"

gem "avo"
gem "bootsnap", require: false
gem "config"
gem "cssbundling-rails"
gem "devise"
gem "flipper-active_record"
gem "flipper-ui"
gem "jsbundling-rails"
gem "govuk_design_system_formbuilder"
gem "mission_control-jobs"
gem "packs-rails"
gem "pg"
gem "phlex-rails"
gem "propshaft"
gem "pagy", "< 9"
gem "puma"
gem "solid_queue"
gem "stimulus-rails"
gem "turbo-rails"

group :development, :test do
  gem "bullet"
  gem "debug", platforms: %i[ mri windows ]
  gem "dockerfile-rails"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "annotate"
  gem "brakeman", require: false
  gem "hotwire-livereload"
  gem "minitest-macos-notification"
  gem "rufo"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "cuprite"
  gem "simplecov", require: false
end
