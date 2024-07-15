class TeamsController < ApplicationController
  before_action :authenticate_user!

  def new
    render New.new(team: current_user.teams.new)
  end

  def create
    team = current_user.teams.create(team_params)
    if team.persisted?
      redirect_to profile_path, success: "Team created"
    else
      render New.new(team:), status: :unprocessable_entity
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  class New < ApplicationComponent
    def initialize(team:)
      @team = team
    end

    def view_template
      form_with(model: @team, url: teams_path) do |f|
        f.govuk_error_summary

        main_heading "Create a new team"

        f.govuk_text_field :name
        f.govuk_submit "Create"
      end
    end
  end
end
