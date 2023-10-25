require "spec_helper"
require "database_cleaner"

feature "Article Creation" do
  #before(:all) do
  #  sign_up
  #end
  scenario "allows user to visit new article page" do
    sign_up
    visit new_article_path
    expect(page).to have_content "New article"
  end

  scenario "was created successfully" do
    sign_up
    visit new_article_path

    fill_in :article_title, :with => 'temp'
    fill_in :article_text, :with => 'article by temp'

    click_button 'Save Article'

    expect(page).to have_content I18n.t('articles.article_details')
  end

end