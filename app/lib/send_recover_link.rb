require 'mailgun'
require 'dotenv'
Dotenv.load

class SendRecoverLink
  def initialize(mailer: nil)
    @mailer = mailer || Mailgun::Client.new("key-501dbef87817211f0933f9fde2d061f2")
  end

  def self.call(user, mailer = nil)
    new(mailer: mailer).call(user)
  end

  def call(user)
    mailer.send_message("sandbox4ea7364b34d64c608f3cc57a4b2699f6.mailgun.org/messages", {from: 'mailgun@sandbox4ea7364b34d64c608f3cc57a4b2699f6.mailgun.org',
              to: 'jamesgardiner075@gmail.com',
              subject: 'reset your password',
              text: "click here to reset your password https://jg075-bookmark-manager.herokuapp.com/reset_password?token=#{user.password_token}"})
  end

  private

  attr_reader :mailer
end
