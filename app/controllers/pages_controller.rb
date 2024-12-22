class PagesController < ApplicationController
  allow_unauthenticated_access

  def home
    render Home.new
  end

  private

  class Home < ApplicationComponent
    def view_template
      article do
        main_heading "Home"

        p { "Nothing to see here. This is still being built." }
      end
    end
  end
end
