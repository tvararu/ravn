class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, except: %i[new create]

  def new
    render New.new(team: current_user.teams.new)
  end

  def edit
    render Edit.new(team: @team)
  end

  def delete
    render Delete.new(team: @team)
  end

  def create
    team = current_user.teams.create(team_params)
    if team.persisted?
      redirect_to profile_path, success: "Team created"
    else
      render New.new(team:), status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy!
    redirect_to profile_path, success: "Team deleted"
  end

  private

  def set_team
    @team = current_user.teams.find(params[:id])
  end

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

  class Edit < ApplicationComponent
    def initialize(team:)
      @team = team
    end

    def view_template
      form_with(model: @team, url: team_path(@team)) do |f|
        f.govuk_error_summary

        main_heading "Edit team details"

        f.govuk_text_field :name
        f.govuk_submit "Update"

        p { link_to "Delete this team", delete_team_path(@team) }
      end
    end
  end

  class Delete < ApplicationComponent
    def initialize(team:)
      @team = team
    end

    def view_template
      main_heading "Are you sure you want to delete the #{@team.name} team?"

      p { "This action is not reversible." }

      p { "All members will be removed from the team." }

      p { "Are you sure you want to delete this team?" }

      button_to "Delete", team_path(@team),
                method: :delete,
                class: "govuk-button govuk-button--warning"
    end
  end
end