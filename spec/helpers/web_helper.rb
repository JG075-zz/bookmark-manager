def add_new_link
  visit "/links/new"
  expect(page.status_code).to eq(200)
  fill_in :url, with: 'www.bbc.co.uk'
  fill_in :title, with: 'BBC'
  fill_in :tags, with: 'news'
  click_button 'Add Link'
end
