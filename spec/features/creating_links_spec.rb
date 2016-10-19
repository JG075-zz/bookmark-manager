
feature 'adding links' do
  scenario 'add new url and title' do
    visit ("/links/new")
    fill_in :url, with: 'www.bbc.co.uk'
    fill_in :title, with: 'BBC'
    click_button 'Add Link'
    expect(page).to have_content('Title: BBC URL: www.bbc.co.uk')
  end
end
