feature 'adding links' do
  scenario 'add new url and title' do
    add_new_link
    expect(page).to have_content('Title: BBC URL: www.bbc.co.uk')
  end
end
