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
      content_for :breadcrumbs do
        render GOVUK::Breadcrumbs.new do |c|
          c.crumb root_path, "Home"
        end
      end

      main_heading "Profile"

      p { "Hello #{@current_user.email}" }

      h2 { "Teams" }

      p {
        link_to "Create a new team", new_team_path
      }

      @current_user.memberships.includes(:team).each do |membership|
        render GOVUK::SummaryCard.new do |card|
          card.title { membership.team.name }
          if membership.personal?
            card.body do
              p do
                "This is your personal team. It cannot be renamed or deleted."
              end
            end
          else
            card.with_action edit_team_path(membership.team), "Manage",
                             "#{membership.team.name} team settings"
          end
        end
      end
    end
  end
end
