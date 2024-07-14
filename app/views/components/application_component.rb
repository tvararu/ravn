class ApplicationComponent < Phlex::HTML
  include Phlex::Rails::Helpers::ButtonTo
  include Phlex::Rails::Helpers::FormWith
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::T

  include GOVUK::Helpers

  unless Rails.env.production?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end
end
