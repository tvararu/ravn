# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  use_layout TwoThirdsLayout
  self.responder = DevisePhlexResponder

  # def new
  #   super
  # end

  # def create
  #   super
  # end

  def edit
    respond_with resource
  end

  # def update
  #   super
  # end

  # def destroy
  #   super
  # end

  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  class New < ApplicationComponent
    def initialize(user:)
      @user = user
    end

    def view_template
      form_with(model: @user, url: user_registration_path) do |f|
        f.govuk_error_summary

        main_heading "Sign up"

        f.govuk_email_field :email, autocomplete: "email"

        f.govuk_password_field :password, autocomplete: "new-password"

        f.govuk_password_field :password_confirmation,
                               label: { text: "Confirm your password" },
                               autocomplete: "new-password"

        f.govuk_submit "Sign up"
      end

      render "users/shared/links"
    end
  end

  class Edit < ApplicationComponent
    def initialize(user:)
      @user = user
    end

    def view_template
      content_for :back_link, profile_path

      form_with(model: @user, url: user_registration_path) do |f|
        f.govuk_error_summary

        main_heading "Change your password"

        f.govuk_password_field :current_password,
                               label: { text: "Current password" },
                               autocomplete: "current-password"

        f.govuk_password_field :password,
                               label: { text: "New password" },
                               autocomplete: "new-password"

        f.govuk_password_field :password_confirmation,
                               label: { text: "Confirm your password" },
                               autocomplete: "new-password"

        f.govuk_submit "Update"
      end
    end
  end
end
