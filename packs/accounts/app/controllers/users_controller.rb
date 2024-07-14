class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render Show.new(current_user:)
  end

  private

  class Show < ApplicationComponent
    def initialize(current_user:)
      @current_user = current_user
    end

    def view_template
      h1 { "Profile" }
      p { "Hello #{@current_user.email}" }

      h2 { "Teams" }

      p {
        link_to "Create a new team", new_team_path
      }

      @current_user.memberships.includes(:team).each do |membership|
        div(class: "govuk-summary-card") do
          div(class: "govuk-summary-card__title-wrapper") do
            h3(class: "govuk-summary-card__title") { membership.team.name }
          end
          div(class: "govuk-summary-card__content") do
            if membership.personal?
              p { "This is your personal team. It can not be deleted." }
            end
            # dl(class: "govuk-summary-list") do
            #   div(class: "govuk-summary-list__row") do
            #     dt(class: "govuk-summary-list__key") { "Age" }
            #     dd(class: "govuk-summary-list__value") { "38" }
            #     dd(class: "govuk-summary-list__actions") do
            #       a(class: "govuk-link", href: "#") { "Change" }
            #     end
            #   end
            # end
          end
        end
      end
    end
  end
end
