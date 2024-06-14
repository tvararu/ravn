class ApplicationLayout < ApplicationComponent
  include Phlex::Rails::Layout

  def view_template(&block)
    doctype

    html(lang: "en") do
      head do
        title { "Ravn" }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
        meta name: "description", content: "Ravn"

        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag "tailwind", "inter-font", data_turbo_track: "reload"
        stylesheet_link_tag "application", data_turbo_track: "reload"
        javascript_importmap_tags
      end

      body do
        main(**classes(%w[container mx-auto mt-28 px-5 flex]), &block)
      end
    end
  end
end
