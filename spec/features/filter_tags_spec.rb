feature 'filter tags' do
  scenario 'when visiting tag url' do

      visit "/links/new"
      fill_in :url, with: 'www.cat.co.uk'
      fill_in :title, with: 'Cat'
      fill_in :tags, with: 'pets'
      click_button 'Add Link'
      visit "/tags/pets"
      expect(page).to have_content('www.cat.co.uk')

  end
end
