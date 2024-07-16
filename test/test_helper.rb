require "simplecov"
SimpleCov.start
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

require "minitest/autorun"
require "minitest/macos_notification"
require "minitest/reporters"

Minitest::Reporters.use!(
  [
    Minitest::Reporters::ProgressReporter.new,
    Minitest::Reporters::MacosNotificationReporter.new(title: I18n.t("app")),
  ],
  ENV,
  Minitest.backtrace_filter
)

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    self.fixture_paths += Dir["#{Rails.root}/packs/*/test/fixtures"]

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    Capybara.server = :puma, { Silent: true }

    # Add more helper methods to be used by all tests here...
  end
end
