# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: "GitHub")
      end
    else
      extra_info = request.env["omniauth.auth"].except(:extra)
      session["devise.github_data"] = extra_info

      alert = @user.errors.messages.values.join("\n")
      redirect_to new_user_registration_url, alert:
    end
  end
end
