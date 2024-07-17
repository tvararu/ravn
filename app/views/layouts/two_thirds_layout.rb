class TwoThirdsLayout < ApplicationLayout
  def view_template
    super do
      div(class: "govuk-grid-row") do
        div(class: "govuk-grid-column-two-thirds") { yield }
      end
    end
  end
end
