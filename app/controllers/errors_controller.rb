class ErrorsController < ApplicationController
  allow_unauthenticated_access
  skip_before_action :verify_authenticity_token

  use_layout TwoThirdsLayout

  def not_found
    render NotFound.new, status: :not_found
  end

  def not_acceptable
    render NotAcceptable.new, status: :not_acceptable
  end

  def unprocessable_entity
    render UnprocessableEntity.new, status: :unprocessable_entity
  end

  def too_many_requests
    render TooManyRequests.new, status: :too_many_requests
  end

  def internal_server_error
    render InternalServerError.new, status: :internal_server_error
  end

  private

  class NotFound < ApplicationComponent
    def view_template
      main_heading "Page not found"

      p do
        "If you entered a web address, check it is correct."
      end

      p do
        "If you pasted the web address, check you copied the entire address."
      end

      p do
        plain "If the web address is correct or you selected a link or button \
               and you need to speak to someone about this problem, contact \
               the #{t("app")} team."
      end
    end
  end

  class NotAcceptable < ApplicationComponent
    def view_template
      main_heading "Sorry, there’s a problem with the service"

      p { "Try again later." }

      p { "If you continue to see this error contact the #{t("app")} team." }
    end
  end

  class UnprocessableEntity < ApplicationComponent
    def view_template
      main_heading "Sorry, there’s a problem with the service"

      p { "Try again later." }

      p { "If you continue to see this error contact the #{t("app")} team." }
    end
  end

  class TooManyRequests < ApplicationComponent
    def view_template
      main_heading "Sorry, you've made too many requests"

      p do
        "Please wait a few minutes before trying again. If you continue to see \
         this message or believe it's an error, contact the #{t("app")} team."
      end
    end
  end

  class InternalServerError < ApplicationComponent
    def view_template
      main_heading "Sorry, there’s a problem with the service"

      p do
        "If you reached this page after submitting information then it has \
         not been saved. You'll need to enter it again when the service is \
         available."
      end

      p do
        "If you have any questions, please contact the #{t("app")} team."
      end
    end
  end
end
