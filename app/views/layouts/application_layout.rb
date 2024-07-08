class ApplicationLayout < ApplicationComponent
  include Phlex::Rails::Helpers::Flash
  include Phlex::Rails::Layout
  include Hotwire::Livereload::LivereloadTagsHelper if Rails.env.development?

  def view_template(&block)
    doctype

    html(lang: "en", class: "govuk-template") do
      head do
        title { t("app") }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
        meta name: "description", content: t("app")

        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag(
          "application",
          data_turbo_track: Rails.env.production? ? "reload" : "",
        )
        javascript_include_tag(
          "application",
          data_turbo_track: Rails.env.production? ? "reload" : "",
          type: "module",
          defer: true,
        )
        hotwire_livereload_tags if Rails.env.development?
      end

      body(class: "govuk-template__body") do
        script do
          unsafe_raw "document.body.className += ' js-enabled' +
            ('noModule' in HTMLScriptElement.prototype
              ? ' govuk-frontend-supported'
              : '');"
        end

        render GOVUK::SkipLink.new
        render GOVUK::Header.new

        div(class: "govuk-width-container") do
          main(class: "govuk-main-wrapper", id: "main-content", role: "main") do
            flash.each do |_, text|
              render GOVUK::NotificationBanner.new(
                title_text: "Important",
                text:,
              )
            end

            yield
          end
        end
      end
    end
  end
end
