require "spec_helper"

feature "Article Edited" do
  scenario "user edites article" do
    sign_up
    article = create(:article, title: 'Lorem Ipsum', text: 'Lorem Ipsum')
    
    visit "/articles/#{article.id}/edit"

    fill_in :article_text, :with => article.text + ' upd v1'

    click_button 'Save changes'

    expect(page).to have_content "upd v1"

  end
end
