class ApplicationController < ActionController::Base
  default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder

  layout -> { ApplicationLayout }

  add_flash_types :success
end
