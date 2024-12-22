class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  rate_limit to: 10, within: 3.minutes, only: :create,
             with: -> {
               redirect_to new_session_path,
                           alert: "Try again later."
             }

  use_layout TwoThirdsLayout

  def new
    render New.new
  end

  def create
    if user = User.authenticate_by(params.permit(:email, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path,
                  alert: "The email address or password you entered is \
                          incorrect. Please try again."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end

  private

  class New < ApplicationComponent
    def view_template
      main_heading "Log in"

      form_with url: session_path do |f|
        f.govuk_email_field :email, autocomplete: "email"

        f.govuk_password_field :password, autocomplete: "current-password"

        f.govuk_submit "Log in"
      end

      p { link_to "Forgot password?", new_password_path }
    end
  end
end
