require 'spec_helper'

feature "Comment Creation" do
  scenario "allows user to create a comment page" do
    sign_up
    article = create(:article, title: 'Lorem Ipsum', text: 'Lorem Ipsum')
    
    visit "/articles/#{article.id}"

    #fill_in :comment_author, with: => current_user.username
    fill_in :comment_body, :with => 'blabla'

    click_button I18n.t('comments.comment_leaved')

    expect(page).to have_content I18n.t('comments.comment_leaved')
  end
end  