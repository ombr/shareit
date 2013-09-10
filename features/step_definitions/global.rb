Given(/^I am loggued in$/) do
end

When(/^I import my box\.com account$/) do
  visit root_path
  click_link 'Import'
  click_link 'Box'
  fill_in 'login', with: 'ombr@ombr.net'
  fill_in 'password', with: ''
  find('.login_submit').click
  find('#consent_accept_button').click
  visit current_url.gsub(ENV['BOX_AUTHORIZE_URL'], box_imports_path)# We remove https for easy testing :-D
end

When(/^I wait for the jobs$/) do
end

Then(/^I should see my hello_world\.txt document$/) do
  page.has_content?('hello_world.txt')
end
