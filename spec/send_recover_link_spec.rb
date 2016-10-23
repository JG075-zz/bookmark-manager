require './app/lib/send_recover_link'

describe SendRecoverLink do
  let(:user){double :user, username: 'test@test.com', password_token: '12345678'}
  let(:mail_gun_client){double :mail_gun_client}
  let(:sandbox_domain_name){ENV["MAILGUN_DOMAIN"]}

  it 'sends a message to mailgun when it is called' do
    params = {from: 'mailgun@sandbox4ea7364b34d64c608f3cc57a4b2699f6.mailgun.org',
              to: user.username,
              subject: 'reset your password',
              text: "click here to reset your password https://jg075-bookmark-manager.herokuapp.com/users/reset_password?token=#{user.password_token}"}
              expect(mail_gun_client).to receive(:send_message).with(sandbox_domain_name, params)
              described_class.call(user, mail_gun_client)
  end
end
