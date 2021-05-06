Feature: Testing Login Facebook API
  Frontend is allowed make POST requests to the api and received responses with JWT token.

  Background: Stub Facebook Request
    Given Stub Facebook Request

  Scenario: FE send a request without Facebook's access token
    When FE send a request no token
    Then API response an unathorized status

  Scenario: FE send a request with Facebook's access token
    When FE send a request an authorization token
    Then API response an success status
    And  API return a jwt token

  Scenario: A new user request a registration via Facebook
    When FE send a request an authorization token
    Then A new user is created
