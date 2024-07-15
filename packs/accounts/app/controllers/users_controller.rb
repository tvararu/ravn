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
      main_heading "Profile"
      p { "Hello #{@current_user.email}" }

      h2 { "Teams" }

      p {
        link_to "Create a new team", new_team_path
      }

      @current_user.memberships.includes(:team).each do |membership|
        render GOVUK::SummaryCard.new do |card|
          card.title { membership.team.name }
          card.body do
            if membership.personal?
              p { "This is your personal team. It can not be deleted." }
            end
          end
        end
      end
    end
  end
end
