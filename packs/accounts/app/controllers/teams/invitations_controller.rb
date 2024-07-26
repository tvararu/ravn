class Teams::InvitationsController < ApplicationController
  use_layout TwoThirdsLayout

  before_action :authenticate_user!
  before_action :set_team

  def new
    render New.new(team: @team, user: User.new)
  end

  def create
    user = User.invite!(user_params)
    if user.errors.empty?
      @team.users << user
      redirect_to profile_path, notice: "Invitation sent to #{user.email}"
    else
      render New.new(team: @team, user: user), status: :unprocessable_entity
    end
  end

  private

  def set_team
    @team = current_user.teams.find(params[:team_id])
  end

  def user_params
    params.require(:user).permit(:email)
  end

  class New < ApplicationComponent
    def initialize(team:, user:)
      @team = team
      @user = user
    end

    def view_template
      content_for :back_link, profile_path

      form_with(model: @user, url: team_invitations_path(@team), method: :post) do |f|
        f.govuk_error_summary

        main_heading "Send invitation"

        f.govuk_text_field :email

        f.govuk_submit "Invite"
      end
    end
  end
end
