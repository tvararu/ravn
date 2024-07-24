# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  use_layout TwoThirdsLayout

  # def new
  #   super
  # end

  # def create
  #   super
  # end

  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  self.responder = Class.new(Devise::Controllers::Responder) do
    def to_html
      if controller.action_name == "new"
        render New.new(user: resource)
      elsif controller.action_name == "create"
        render New.new(user: resource), status: :unprocessable_entity
      else
        super
      end
    end
  end

  class New < ApplicationComponent
    def initialize(user:)
      @user = user
    end

    def view_template
      main_heading "Log in"

      form_with(model: @user, url: user_session_path) do |f|
        f.govuk_email_field :email, autocomplete: "email"

        f.govuk_password_field :password, autocomplete: "current-password"

        f.hidden_field :remember_me, value: "true"

        f.govuk_submit "Log in"
      end

      render "devise/shared/links"
    end
  end
end
