require 'mailgun'

class SendRecoverLink
  def initialize(mailer: nil)
    @mailer = mailer || Mailgun::Client.new(ENV["MAILGUN_API"])
  end

  def self.call(user, mailer = nil)
    new(mailer: mailer).call(user)
  end

  def call(user)
    p user.username
    mailer.send_message(ENV["MAILGUN_DOMAIN"], {from: 'mailgun@sandbox4ea7364b34d64c608f3cc57a4b2699f6.mailgun.org',
              to: user.username,
              subject: 'reset your password',
              text: "click here to reset your password https://jg075-bookmark-manager.herokuapp.com/reset_password?token=#{user.password_token}"})
  end

  private

  attr_reader :mailer
end
