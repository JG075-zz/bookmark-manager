feature 'User sign up' do
  scenario 'sign up with valid entries' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.username).to eq('alice@example.com')
  end

  scenario 'sign up with wrong password confirmation' do
    visit '/users/new'
    fill_in :username, with: 'alice@example.com'
    fill_in :password, with: 'oranges!'
    fill_in :password_confirmation, with: 'apples!'
    expect { click_button 'Submit' }.not_to change(User, :count)
    expect(page).to have_current_path('/users')
    expect(page).to have_content('Password does not match the confirmation')
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
    fill_in :username, with: 'alice-example.com'
    fill_in :password, with: 'oranges!'
    fill_in :password_confirmation, with: 'oranges!'
    expect { click_button 'Submit' }.not_to change(User, :count)
    expect(page).to have_current_path('/users')
  end

  scenario 'sign up with an already registered email' do
    sign_up
    expect { sign_up }.not_to change(User, :count)
    expect(page).to have_content('Username is already taken')
  end
end

feature 'User login' do
  let!(:user) do
    User.create(username: 'testmail@mail.com',
    password: 'apples',
    password_confirmation: 'apples')
  end

  scenario 'with correct credentials' do
    sign_in(username: user.username, password: user.password)
    expect(page).to have_content("Welcome, #{user.username}")
  end
end

feature 'User sign out' do
  before(:each) do
    User.create(username: 'testmail@mail.com',
    password: 'apples',
    password_confirmation: 'apples')
  end

  scenario 'when logged in' do
    sign_in(username: 'testmail@mail.com', password: 'apples')
    click_button 'Sign out'
    expect(page).to have_content("You signed out. Thanks for using Bookmark Manager")
    expect(page).not_to have_content("Welcome, testmail@mail.com")
  end
end
