# features/step_definitions/link_click_steps.rb
Given(/^I go to the homepage$/) do
  visit '/'
end


Then(/^I see a Facebook Login button$/) do
  expect(page).to have_content("Link Clicked")
end