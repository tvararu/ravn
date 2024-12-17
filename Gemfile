source "https://rubygems.org"

ruby file: ".ruby-version"
gem "rails", "~> 8.0.1"

# Framework default gems
gem "bcrypt"                                  # Password hashing
gem "bootsnap", require: false                # Reduces boot times
gem "cssbundling-rails"                       # Sass support
gem "jsbundling-rails"                        # ESBuild support
gem "pg"                                      # PostgreSQL adapter
gem "propshaft"                               # Asset pipeline
gem "puma"                                    # Web server
gem "solid_queue"                             # Background jobs
gem "stimulus-rails"                          # Stimulus support
gem "turbo-rails"                             # Turbo support
gem "thruster", require: false                # Prod-ready proxy

# 3rd party gems
gem "avo"                                     # Admin panel
gem "flipper-active_record"                   # Feature flags
gem "flipper-ui"                              # Feature flags dashboard
gem "govuk_design_system_formbuilder"         # Form builder
gem "mission_control-jobs"                    # Background jobs dashboard
gem "packs-rails"                             # ./packs support
gem "phlex-rails"                             # Reusable components
gem "postmark-rails"                          # Email delivery
gem "sentry-rails"                            # Error tracking
gem "stackprof"                               # Needed by postmark

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false              # Security static analysis
  gem "rubocop-rails-omakase", require: false # Linting

  gem "bullet"                                # N+1 query detection
  gem "rufo"                                  # Ruby formatter
end

group :development do
  gem "web-console"                           # Console on error pages

  gem "annotaterb"                            # Annotate models
  gem "hotwire-livereload"                    # Reload browser on code changes
  gem "minitest-macos-notification"           # Notifications on test failures
end

group :test do
  gem "capybara"                              # Browser testing

  gem "cuprite"                               # Chromium testing
  gem "simplecov", require: false             # Test coverage
end
