module GOVUK
  class Header < ApplicationComponent
    def view_template
      header(data: { module: "govuk-header" }, class: "govuk-header") do
        div(class: "govuk-header__container govuk-width-container") do
          div(class: "govuk-header__logo") do
            a(class: "govuk-header__link govuk-header__link--homepage",
              href: root_path) do
              strong { "App" }
            end
          end
        end
      end
    end
  end

  class NotificationBanner < ApplicationComponent
    def initialize(title_text:, text:)
      @title_text = title_text
      @text = text
    end

    def view_template
      div(class: "govuk-notification-banner",
          data: { module: "govuk-notification-banner" },
          role: "region",
          aria: { labelledby: "govuk-notification-banner-title" }) do
        div(class: "govuk-notification-banner__header") do
          h2(class: "govuk-notification-banner__title",
             id: "govuk-notification-banner-title") { @title_text }
        end
        div(class: "govuk-notification-banner__content") { @text }
      end
    end
  end

  class SkipLink < ApplicationComponent
    def view_template
      a(class: "govuk-skip-link",
        href: "#main-content",
        data: { module: "govuk-skip-link" }) { "Skip to main content" }
    end
  end
end
