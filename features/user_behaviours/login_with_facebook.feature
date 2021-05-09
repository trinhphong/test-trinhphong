Feature: Testing Login Facebook - User behaviours
  User is allowed to login in via Facebook

  Background: Stub Facebook Request
    Given Stub Facebook Request

  Scenario: User log in with Facebook successfully
    When User visit our page
    Then User see the LOGIN WITH FACEBOOK button
    And  User click on LOGIN WITH FACEBOOK button
    Then User fill in email and password then press login
    Then User is redirected to profile page
    And  User see their profile

  Scenario: User doesn't accept permission to login via Facebook
    When User visit our page
    Then User see the LOGIN WITH FACEBOOK button
    And  User click on LOGIN WITH FACEBOOK button
    Then User fill in email and password but not accept permission
    And  User still be on login page