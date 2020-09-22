@android
Feature: Login Feature

  Scenario: Verify user able to login with valid account
    Given I register and back to login page
    When I input valid email and password
    Then I click "Login Button"
    And I should see "test@test.com" text

  Scenario: Verify that User is not able to Login with invalid email and invalid Password
    When I type "asd@asd.com" on "Email Field"
    Then I type "asd" on "Password Field"
    Then I click "Login Button"
    And I should see "Wrong Email And Password" text

  Scenario: Verify that User is not able to Login with Valid email and invalid Password
    When I type "test@test.com" on "Email Field"
    Then I type "asd" on "Password Field"
    Then I click "Login Button"
    And I should see "Wrong Email And Password" text
#
  Scenario: Verify that User is not able to Login with invalid Username and Valid Password
    When I type "asd@asd.com" on "Email Field"
    Then I type "123" on "Password Field"
    Then I click "Login Button"
    And I should see "Wrong Email And Password" text
#
  Scenario: Verify that User is not able to Login with blank Username or Password
    When I click "Login Button"
    Then I should see "Enter Valid Email" text
