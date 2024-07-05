class ApplicationLayout < ApplicationComponent
  include Phlex::Rails::Helpers::Flash
  include Phlex::Rails::Layout
  include Hotwire::Livereload::LivereloadTagsHelper if Rails.env.development?

  def view_template(&block)
    doctype

    html(lang: "en") do
      head do
        title { t("app") }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
        meta name: "description", content: t("app")

        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag(
          "application",
          data_turbo_track: Rails.env.production? ? "reload" : "",
        )
        javascript_include_tag(
          "application",
          data_turbo_track: Rails.env.production? ? "reload" : "",
          type: "module",
          defer: true,
        )
        hotwire_livereload_tags if Rails.env.development?
      end

      body do
        main(**classes(%w[container mx-auto p-5])) do
          flash.each do |_, message|
            p(class: "alert mb-5", data_turbo_cache: "false") { message }
          end

          yield
        end
      end
    end
  end
end
