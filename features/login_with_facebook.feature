Feature: Login With Facebook
  As a guest
  I want our users to be allowed login via facebook

  Scenario: User visit the root page
    When I go to the homepage
    Then I see a Facebook Login button

  # @javascript
  # Scenario: User loggin by clicking on LOGIN WITH FACEBOOK button
  #   When I go to the homepage
  #   Then I see a Facebook Login button
  #   When I click on the LOGIN WITH FACEBOOK
  #   Then I see a pop up which ask facebook permission