class ApplicationLayout < ApplicationComponent
  include Phlex::Rails::Helpers::Flash
  include Phlex::Rails::Layout
  include Hotwire::Livereload::LivereloadTagsHelper if Rails.env.development?

  def view_template
    doctype

    html(lang: "en", class: "govuk-template") do
      head do
        title { helpers.page_title }
        meta name: "viewport",
          content: "width=device-width,initial-scale=1,viewport-fit=cover"
        meta name: "theme-color", content: "#0b0c0c"
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
          plain content_for(:breadcrumbs)
          govuk_back_link(content_for(:back_link)) if content_for(:back_link)

          main(class: "govuk-main-wrapper", id: "main-content") do
            flash.each do |type, text|
              render GOVUK::NotificationBanner.new(type:, text:)
            end

            yield
          end
        end

        render GOVUK::Footer.new
      end
    end
  end
end
