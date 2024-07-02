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
      p { "Hello #{@current_user.email}" }
    end
  end
end
