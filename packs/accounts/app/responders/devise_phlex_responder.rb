# frozen_string_literal: true

class DevisePhlexResponder < Devise::Controllers::Responder
  def to_html
    if get?
      render_component(controller.action_name)
    elsif controller.flash.alert.present?
      render_component(default_action, status: :unprocessable_entity)
    else
      redirect_to resource_location
    end
  end

  private

  def render_component(action, **options)
    component = "#{controller.class.name}::#{action.to_s.capitalize}".constantize
    controller.render component.new(user: resource), **options
  end
end
