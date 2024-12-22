class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]

  use_layout TwoThirdsLayout

  def new
    render New.new
  end

  def create
    if user = User.find_by(email: params[:email])
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_path, notice: "Password reset instructions sent (if user with that email address exists)."
  end

  def edit
    render Edit.new
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: "Password has been reset."
    else
      redirect_to edit_password_path(params[:token]), alert: "Passwords did not match."
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_password_reset_token!(params[:token])
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
  end

  private

  class New < ApplicationComponent
    def view_template
      main_heading "Forgot your password?"

      form_with url: passwords_path do |f|
        f.govuk_email_field :email,
                            autocomplete: "email",
                            value: helpers.params[:email]

        f.govuk_submit "Email reset instructions"
      end
    end
  end

  class Edit < ApplicationComponent
    def view_template
      main_heading "Update your password"

      form_with url: password_path(helpers.params[:token]), method: :put do |f|
        f.govuk_password_field :password,
                               autocomplete: "new-password",
                               label: { text: "Enter new password" }

        f.govuk_password_field :password_confirmation,
                               autocomplete: "new-password",
                               label: { text: "Repeat new password" }

        f.govuk_submit "Save"
      end
    end
  end
end
