require "spec_helper"

def sign_up
  
  visit new_user_registration_path

  fill_in :user_email, :with => 'newby2@ex.com'
  fill_in :user_username, :with => 'newby2'
  fill_in :user_password, :with => '654321'
  fill_in :user_password_confirmation, :with => '654321'

  click_button 'Sign up'  

end

