Given(/^I am loggued in$/) do
end

When(/^I import my box\.com account$/) do
  visit root_url
  click_link 'Import'
  click_link 'box'
end

When(/^I wait (\d+) seconds$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see my hello_world\.txt document$/) do
  pending # express the regexp above with the code you wish you had
end
