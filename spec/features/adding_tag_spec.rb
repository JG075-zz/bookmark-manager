feature 'adding tags to links' do
  scenario 'adding a single tag to a single link' do
      add_new_link
      link = Link.first
      expect(link.tags.map(&:name)).to include('news')
  end
end
