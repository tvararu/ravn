class ApplicationComponent < Phlex::HTML
  include Phlex::Rails::Helpers::ButtonTo
  include Phlex::Rails::Helpers::ContentFor
  include Phlex::Rails::Helpers::FormWith
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::T

  include GOVUK::Helpers

  register_value_helper :params

  unless Rails.env.production?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end

  private

  def main_heading(page_title)
    content_for(:page_title) { page_title }
    h1 { page_title }
  end
end
