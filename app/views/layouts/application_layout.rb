class ApplicationLayout < ApplicationComponent
  include Phlex::Rails::Helpers::Flash
  include Phlex::Rails::Layout
  include Hotwire::Livereload::LivereloadTagsHelper if Rails.env.development?

  def view_template(&block)
    doctype

    html(lang: "en") do
      head do
        title { "Ravn" }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
        meta name: "description", content: "Ravn"

        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag(
          "tailwind", "inter-font", "application",
          data_turbo_track: Rails.env.production? ? "reload" : "",
        )
        javascript_importmap_tags
        hotwire_livereload_tags if Rails.env.development?
      end

      body do
        main(**classes(%w[container mx-auto p-5])) do
          flash.each do |_, message|
            p(class: "bg-blue-500 text-white p-4 rounded-md") { message }
          end

          yield
        end
      end
    end
  end
end