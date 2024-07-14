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
      ul(class: "govuk-list govuk-list--bullet") {
        @current_user.teams.each { |team| li { team.name } }
      }
    end
  end
end
