module GOVUK
  module Helpers
    def govuk_button_to(body, url, options = {})
      button_to body, url,
                options.merge(
                  class: "govuk-button",
                  "data-module": "govuk-button",
                )
    end
  end

  class Footer < ApplicationComponent
    def view_template
      footer(class: "govuk-footer") do
        div(class: "govuk-width-container") do
          div(class: "govuk-footer__meta") do
            div(class: "govuk-footer__meta-item
                        govuk-footer__meta-item--grow") do
              a(class: "govuk-footer__link",
                href: "https://github.com/tvararu/ravn") do
                "Source code"
              end
            end
          end
        end
      end
    end
  end

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
    def initialize(type:, text:)
      @type = type
      @text = text
    end

    def view_template
      div(**classes("govuk-notification-banner",
                    success?: "govuk-notification-banner--success"),
          data: { module: "govuk-notification-banner" },
          role: "region",
          aria: { labelledby: "govuk-notification-banner-title" }) do
        div(class: "govuk-notification-banner__header") do
          h2(class: "govuk-notification-banner__title",
             id: "govuk-notification-banner-title") { @type.humanize }
        end
        div(class: "govuk-notification-banner__content") {
          h3(class: "govuk-notification-banner__heading") { @text }
        }
      end
    end

    private

    def success? = @type == "success"
  end

  class SkipLink < ApplicationComponent
    def view_template
      a(class: "govuk-skip-link",
        href: "#main-content",
        data: { module: "govuk-skip-link" }) { "Skip to main content" }
    end
  end

  class SummaryCard < ApplicationComponent
    include Phlex::DeferredRender

    def initialize
      @actions = []
      @rows = []
    end

    def view_template
      div(class: "govuk-summary-card") do
        div(class: "govuk-summary-card__title-wrapper") do
          h3(class: "govuk-summary-card__title") { @title.call }
          ul(class: "govuk-summary-card__actions") do
            @actions.each do |href, text, hidden_text|
              li(class: "govuk-summary-card__action") do
                a(class: "govuk-link", href:) do
                  plain text
                  span(class: "govuk-visually-hidden") { hidden_text } if hidden_text
                end
              end
            end
          end
        end
        div(class: "govuk-summary-card__content") do
          @body.call if @body

          dl(class: "govuk-summary-list") do
            @rows.each do |key, value, href, link_text, link_hidden_text|
              div(class: "govuk-summary-list__row") do
                dt(class: "govuk-summary-list__key") { key }
                dd(class: "govuk-summary-list__value") { value }
                dd(class: "govuk-summary-list__actions") {
                  a(class: "govuk-link", href:) do
                    plain link_text
                    span(class: "govuk-visually-hidden") { link_hidden_text } if link_hidden_text
                  end
                } if href
              end
            end
          end
        end
      end
    end

    def title(&block) = @title = block

    def body(&block) = @body = block

    def with_action(href, text, hidden_text = nil)
      @actions << [href, text, hidden_text]
    end

    def with_row(key, value, href = nil, link_text = nil, link_hidden_text = nil)
      @rows << [key, value, href, link_text, link_hidden_text]
    end
  end
end