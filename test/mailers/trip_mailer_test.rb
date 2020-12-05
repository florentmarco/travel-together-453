require 'test_helper'

class TripMailerTest < ActionMailer::TestCase
  test "share" do
    mail = TripMailer.share
    assert_equal "Share", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
