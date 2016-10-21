feature 'Add multiple tags' do
  scenario 'when user adds more than one tag' do
      visit "/links/new"
      fill_in :url, with: 'www.chinchilla.co.uk'
      fill_in :title, with: 'Chinchilla'
      fill_in :tags, with: 'animal,creature,pet'
      click_button 'Add Link'
      visit "/tags/animal"
      expect(page).to have_content("www.chinchilla.co.uk")
      visit "/tags/creature"
      expect(page).to have_content("www.chinchilla.co.uk")
      visit "/tags/pet"
      expect(page).to have_content("www.chinchilla.co.uk")
  end
end
