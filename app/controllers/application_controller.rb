class ApplicationController < ActionController::Base
  default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder

  layout -> { ApplicationLayout.new(current_user:) }

  add_flash_types :success

  private

  def self.use_layout(custom_layout, only: nil, except: nil)
    layout -> do
             method = action_name.to_sym
             use_custom_layout = (only.present? && only.include?(method)) ||
                                 (except.present? && except.exclude?(method)) ||
                                 (only.blank? && except.blank?)

             (use_custom_layout ? custom_layout : ApplicationLayout)
               .new(current_user:)
           end
  end
end
