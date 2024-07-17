class PagesController < ApplicationController
  def home
    render Home.new(current_user:)
  end

  private

  class Home < ApplicationComponent
    def initialize(current_user:)
      @current_user = current_user
    end

    def view_template
      article do
        main_heading "Home"

        if @current_user
          p {
            govuk_button_to "Logout", destroy_user_session_path, method: :delete
          }
        else
          p { link_to "Sign in", new_user_session_path }
        end
      end
    end
  end
end
