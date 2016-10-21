feature 'adding tags to links' do
  scenario 'adding a single tag to a single link' do

      visit "/links/new"
      fill_in :url, with: 'www.bbc.co.uk'
      fill_in :title, with: 'BBC'
      fill_in :tags, with: 'News'
      click_button 'Add Link'
      link = Link.first
      expect(link.tags.map(&:name)).to include('News')

  end
end
