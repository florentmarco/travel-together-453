# Preview all emails at http://localhost:3000/rails/mailers/trip_mailer
class TripMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/trip_mailer/share
  def share
    TripMailer.share
  end

end
