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
      end
    end
  end
end
