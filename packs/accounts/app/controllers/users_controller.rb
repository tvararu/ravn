class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    memberships = current_user.memberships.eager_load(team: :users)
    render Show.new(memberships:)
  end

  private

  class Show < ApplicationComponent
    def initialize(memberships:)
      @memberships = memberships
    end

    def view_template
      content_for :breadcrumbs do
        render GOVUK::Breadcrumbs.new do |c|
          c.crumb root_path, "Home"
        end
      end

      main_heading "Profile"

      p {
        link_to "Change your password", edit_user_registration_path
      }

      h2 { "Teams" }

      p {
        link_to "Create a new team", new_team_path
      }

      @memberships.each do |membership|
        render GOVUK::SummaryCard.new do |card|
          card.title(tag: :h3) { membership.team.name }
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
          card.with_row "Members",
                        href: new_team_invitation_path(membership.team),
                        link_text: "Invite members",
                        link_hidden_text: "to #{membership.team.name} team" do
            govuk_list do
              membership.team.users.each do |user|
                li { user.email }
              end
            end
          end
        end
      end
    end
  end
end
