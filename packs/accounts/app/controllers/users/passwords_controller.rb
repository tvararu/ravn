# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  use_layout TwoThirdsLayout
  self.responder = DevisePhlexResponder

  # GET /resource/password/new
  def new
    super
    respond_with resource
  end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
    respond_with resource
  end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  private

  class New < ApplicationComponent
    def initialize(user:)
      @user = user
    end

    def view_template
      form_with(model: @user, url: user_password_path) do |f|
        f.govuk_error_summary

        main_heading "Forgot your password?"

        f.govuk_text_field :email, autocomplete: "email"

        f.govuk_submit "Submit"
      end

      render "devise/shared/links"
    end
  end

  class Edit < ApplicationComponent
    def initialize(user:)
      @user = user
    end

    def view_template
      form_with(model: @user, url: user_password_path, method: :put) do |f|
        f.govuk_error_summary

        main_heading "Change your password"

        f.hidden_field :reset_password_token

        f.govuk_password_field :password, autocomplete: "new-password"

        f.govuk_password_field :password_confirmation,
                               label: { text: "Confirm your password" },
                               autocomplete: "new-password"

        f.govuk_submit "Update"
      end

      render "devise/shared/links"
    end
  end
end
