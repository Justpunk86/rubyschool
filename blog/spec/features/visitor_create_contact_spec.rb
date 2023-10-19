require "spec_helper"

feature "Contact Creation" do

  scenario "allows access to contacts page" do 
    visit '/contacts'

    expect(page).to have_content I18n.t('contacts.contact_us')
  end

  scenario "allows a guest to create contact" do
    visit '/contacts'
    fill_in :contact_name, :with => 'temp'
    fill_in :contact_phone, :with => '111'
    fill_in :contact_email, :with => 'guest@example.com'
    fill_in :contact_message, :with => 'someting'

    click_button 'Send message'

    expect(page).to have_content 'Thanks!'
  end
end    