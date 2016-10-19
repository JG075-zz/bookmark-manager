feature 'adding tags to links' do
scenario 'adding a single tag to a single link' do
  p "pie"
  visit "/links/new"
    fill_in :url, with: 'www.bbc.co.uk'
    fill_in :title, with: 'BBC'
    fill_in :tag, with: 'News'
    click_button 'Add Link'
    expect(page).to have_content('Title: BBC URL: www.bbc.co.uk Tag: News')
end
end
