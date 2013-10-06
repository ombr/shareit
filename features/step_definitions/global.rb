Given(/^I am loggued in$/) do
  password = 'myamazongpassword'
  @user = FactoryGirl.create :user, password: password
  visit new_user_session_path
  fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: password
  click_button 'Sign in'
end

When(/^I import my box\.com account$/) do
  visit root_path
  click_link 'Import'
  click_link 'Box'
  fill_in 'login', with: ENV['TEST_BOX_LOGIN']
  fill_in 'password', with: ENV['TEST_BOX_PASSWORD']
  find('.login_submit').click
  find('#consent_accept_button').click
  visit current_url.gsub(ENV['BOX_AUTHORIZE_URL'], box_imports_path)# We remove https for easy testing :-D
end

When(/^I Wait for the jobs$/) do
  while Delayed::Job.count > 0
    Delayed::Worker.new.work_off
  end
end

When(/^I import theses files :$/) do |table|
  table.raw.each do |line|
    file = File.open File.join(Rails.root, line[1])
    Item.create!(
      path: line[0],
      file: line[1],
      user: @user
    )
  end
end

Then(/^I should see my post "(.*?)"\.$/) do |name|
  visit user_posts_path(user_id: @user)
  expect(page).to have_content name
  sleep 3
end

Given(/^I am a guest$/) do
end

When(/^I visit the home page$/) do
  visit root_path
end

When(/^click on (.*)$/) do |link|
  click_link link
end

When(/^fill a username, email and password and submit the form$/) do
  fill_in 'user_email', with: 'luc@boissaye.fr'
  fill_in 'user_password', with: 'myamazingpassword'
  click_button 'Sign up'
end

Then(/^see a warning about my confirmation$/) do
  expect(page).to have_content "Warning, you should confirm your email."
end

Given(/^I have an account$/) do
  @user = FactoryGirl.create :user
end



Then(/^I should be loggued in\.$/) do
  expect(page).to have_content "Log out"
end

Then(/^receive a confirmation email\.$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^fill my username and password$/) do
  fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: @user.password
  click_button 'Sign in'
end
