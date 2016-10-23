feature 'User sign up' do
  scenario 'sign up with valid entries' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.username).to eq('alice@example.com')
  end

  scenario 'sign up with wrong password confirmation' do
    visit '/users/new'
    fill_in :username,    with: 'alice@example.com'
    fill_in :password, with: 'oranges!'
    fill_in :password_confirmation, with: 'apples!'
    expect { click_button 'Submit' }.not_to change(User, :count)
    expect(page).to have_current_path('/users')
    expect(page).to have_content('Password and confirmation password do not match')
  end

  scenario 'sign up with a blank email address' do
    visit '/users/new'
    fill_in :password, with: 'oranges!'
    fill_in :password_confirmation, with: 'oranges!'
    expect { click_button 'Submit' }.not_to change(User, :count)
    expect(page).to have_current_path('/users')
  end

  scenario 'sign up with a invalid email address' do
    visit '/users/new'
    fill_in :username,    with: 'alice-example.com'
    fill_in :password, with: 'oranges!'
    fill_in :password_confirmation, with: 'oranges!'
    expect { click_button 'Submit' }.not_to change(User, :count)
    expect(page).to have_current_path('/users')
  end
end
