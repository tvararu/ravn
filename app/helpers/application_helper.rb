module ApplicationHelper
  def page_title
    title = content_for(:page_title)

    if title.blank?
      raise ArgumentError, "No page title set. Either use the main_heading \
                            helper in your page or set it with \
                            content_for(:page_title)."
    end

    title = "Error: #{title}" if response.status == 422

    [title, t("app")].join(" – ")
  end
end
