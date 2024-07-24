# frozen_string_literal: true

class DevisePhlexResponder < Devise::Controllers::Responder
  def to_html
    if %w[new create edit].include?(controller.action_name)
      send("render_#{controller.action_name}")
    else
      super
    end
  end

  private

  def render_new
    render_component(:new)
  end

  def render_create
    render_component(:new, status: :unprocessable_entity)
  end

  def render_edit
    render_component(:edit)
  end

  def render_component(action, **options)
    component = "#{controller.class.name}::#{action.to_s.capitalize}".constantize
    render component.new(user: resource), **options
  end
end
