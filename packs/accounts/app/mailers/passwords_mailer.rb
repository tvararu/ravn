class PasswordsMailer < ApplicationMailer
  def reset(user)
    href = edit_password_url(user.password_reset_token)
    mail subject: "Reset your password", to: user.email,
         body: ResetEmail.new(href:).call
  end

  private

  class ResetEmail < ApplicationComponent
    def initialize(href:)
      @href = href
    end

    def view_template
      p do
        plain "You can reset your password within the next 15 minutes on "
        a(href: @href) { "this password reset page" }
        plain "."
      end
    end
  end
end
