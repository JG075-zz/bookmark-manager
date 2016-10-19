feature 'see_links' do
  scenario 'see links on homepage' do
    Link.create(url: 'http://www.google.com', title: 'Google')

    visit "/links"
    expect(page).to have_content('Google')
  end
end
