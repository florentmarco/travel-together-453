class TripMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.trip_mailer.share.subject
  #
  def share(token,email,subject,start_date,end_date,trip_name,trip_user)
    @token = token
    @trip_start_date = start_date
    @trip_end_date = end_date
    @trip_name = trip_name
    @trip_user = trip_user
    mail(to: email, subject: subject)
  end
end
