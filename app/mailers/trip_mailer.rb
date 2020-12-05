class TripMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.trip_mailer.share.subject
  #
  def share(data,email,subject)
    @body = data
    mail(to: email, subject: subject)
  end
end
