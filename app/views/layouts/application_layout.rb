class ApplicationLayout < ApplicationComponent
  include Phlex::Rails::Layout
  include Hotwire::Livereload::LivereloadTagsHelper

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
        main(**classes(%w[container mx-auto mt-28 px-5 flex]), &block)
      end
    end
  end
end
