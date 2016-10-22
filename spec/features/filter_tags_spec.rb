feature 'filter tags' do
  scenario 'when visiting tag url' do
      add_new_link
      visit "/tags/news"
      expect(page).to have_content('www.bbc.co.uk')
  end
end
