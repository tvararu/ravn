class Users::InvitationsController < Devise::InvitationsController
  use_layout TwoThirdsLayout
  self.responder = DevisePhlexResponder

  def new
    self.resource = resource_class.new
    respond_with resource
  end

  def edit
    set_minimum_password_length
    resource.invitation_token = params[:invitation_token]
    respond_with resource
  end

  private

  class New < ApplicationComponent
    def initialize(user:)
      @user = user
    end

    def view_template
      form_with(model: @user, url: user_invitation_path) do |f|
        f.govuk_error_summary

        main_heading t("devise.invitations.new.header")

        @user.class.invite_key_fields.each do |field|
          f.govuk_text_field field
        end

        f.govuk_submit t("devise.invitations.new.submit_button")
      end
    end
  end

  class Edit < ApplicationComponent
    def initialize(user:)
      @user = user
    end

    def template
      form_with(model: @user, url: user_invitation_path, method: :put) do |f|
        f.govuk_error_summary

        main_heading t("devise.invitations.edit.header")
        f.hidden_field :invitation_token, readonly: true

        if f.object.class.require_password_on_accepting
          f.govuk_password_field :password,
                                 autocomplete: "new-password"

          f.govuk_password_field :password_confirmation,
                                 label: { text: "Confirm your password" },
                                 autocomplete: "new-password"
        end

        f.govuk_submit t("devise.invitations.edit.submit_button")
      end
    end
  end
end
