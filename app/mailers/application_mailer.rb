class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@ravn.fly.dev"
  layout "mailer"
end
