Given(/^I am loggued in$/) do
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

When(/^I wait for the jobs$/) do
end

Then(/^I should see my hello_world\.txt document$/) do
  expect(page).to have_content name 'hello_world.txt'
end

When(/^I import theses files :$/) do |table|
  table.raw.each do |line|
    file = File.open File.join(Rails.root, line[1])
    Item.create!(
      path: line[0],
      file: line[1]
    )
  end
end

Then(/^I should see my post "(.*?)"\.$/) do |name|
  visit root_path
  expect(page).to have_content name
  sleep 3
end
