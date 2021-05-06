Feature: Testing Users API
  Frontend is allowed make GET requests to the api then receive their user data.

  Background: Create User
    Given Create sample users

  Scenario: Get correct user data
    When FE send a request with a valid jwt token
    Then API response an user data correctly
