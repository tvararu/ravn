class PagesController < ApplicationController
  def home
    render Home
  end

  private

  class Home < ApplicationView
    def view_template
      div do
        h1(class: "font-bold text-4xl") { "Pages#home" }
        p { "Find me in app/controllers/pages_controller.rb" }
      end
    end
  end
end
