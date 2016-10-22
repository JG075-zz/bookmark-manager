def add_new_link
  visit "/links/new"
  expect(page.status_code).to eq(200)
  fill_in :url, with: 'www.bbc.co.uk'
  fill_in :title, with: 'BBC'
  fill_in :tags, with: 'news'
  click_button 'Add Link'
end

def sign_up
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :username,    with: 'alice@example.com'
  fill_in :password, with: 'oranges!'
  click_button 'Submit'
end
