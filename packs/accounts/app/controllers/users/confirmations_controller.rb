# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  use_layout TwoThirdsLayout
  self.responder = DevisePhlexResponder

  # GET /resource/confirmation/new
  def new
    self.resource = resource_class.new
    respond_with resource
  end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end

  private

  class New < ApplicationComponent
    def initialize(user:)
      @user = user
    end

    def view_template
      form_with(model: @user, url: user_confirmation_path, method: :post) do |f|
        f.govuk_error_summary

        main_heading "Resend confirmation instructions"

        f.govuk_email_field :email,
                            autocomplete: "email",
                            value: (@user.pending_reconfirmation? ?
                              @user.unconfirmed_email : @user.email)

        f.govuk_submit "Submit"
      end

      render "devise/shared/links"
    end
  end

  class Show < ApplicationComponent
    def initialize(user:)
      @user = user
    end

    def view_template
      main_heading "Your account has been confirmed"
    end
  end
end
