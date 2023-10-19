def sign_up
  visit new_user_registration_path

  fill_in :user_email, :with => 'guest@example.com'
  fill_in :user_username, :with => 'temp'
  fill_in :user_password, :with => '123456'
  fill_in :user_password_confirmation, :with => '123456'

  click_button 'Sign up'  
end