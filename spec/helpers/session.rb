module SessionHelpers
  def sign_up
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :username, with: 'alice@example.com'
    fill_in :password, with: 'oranges!'
    fill_in :password_confirmation, with: 'oranges!'
    click_button 'Submit'
  end

  def sign_in(username:, password:)
    visit '/sessions/new'
    expect(page.status_code).to eq(200)
    fill_in :username, with: username
    fill_in :password, with: password
    click_button 'Submit'
  end
end
