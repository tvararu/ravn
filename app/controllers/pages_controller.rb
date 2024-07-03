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
      article(class: "prose") do
        h1 { "Home" }

        if @current_user
          p { link_to "My profile", profile_path }
          p {
            button_to "Logout", destroy_user_session_path, class: "btn",
                                                           method: :delete
          }
        else
          p { link_to "Sign in", new_user_session_path }
        end
      end
    end
  end
end
