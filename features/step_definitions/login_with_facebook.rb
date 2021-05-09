When(/^User visit our page$/) do
  visit('http://localhost:19006/login')
end

Then(/^User see the LOGIN WITH FACEBOOK button$/) do
  expect(page).to have_content("login")
  expect(page).to have_content("LOGIN WITH FACEBOOK")
end

And(/^User click on LOGIN WITH FACEBOOK button$/) do
  click_on 'Login with Facebook'
end

Then(/^User fill in email and password then press login$/) do
  main = page.driver.browser.window_handles.first

  popup = page.driver.browser.window_handles.last
  page.driver.browser.switch_to.window(popup)

  fill_in 'email', with: 'test_kfscezi_user@tfbnw.net'
  fill_in 'pass', with: '45tgbhu89'
  click_on 'Log In'

  page.driver.browser.switch_to.window(main)
end

Then(/^User is redirected to profile page$/) do
  expect(page).to have_content("profile")
end

And(/^User see their profile$/) do
  expect(page).to have_content('test_kfscezi_user@tfbnw.net')
  expect(page).to have_content('Test User')
end

And(/^User fill in email and password but not accept permission$/) do
  main = page.driver.browser.window_handles.first

  popup = page.driver.browser.window_handles.last
  page.driver.browser.switch_to.window(popup)

  fill_in 'email', with: 'not_ncdpted_user@tfbnw.net'
  fill_in 'pass', with: '45tgbhu89'
  click_on 'Log In'
  # TODO: Investigate why cannot click on button instead of parent class
  page.find('._9m54').click

  page.driver.browser.switch_to.window(main)
end

And(/^User is on login page$/) do
  expect(page).to have_content("login")
  expect(page).to have_content("LOGIN WITH FACEBOOK")
end

And(/^User see the Sign Out button$/) do
  expect(page).to have_content("SIGN OUT")
end

Then(/^User click on the Sign Out button$/) do
  page.find("div[aria-label='Sign Out']").click
end