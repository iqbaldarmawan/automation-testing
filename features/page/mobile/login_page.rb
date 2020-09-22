Given (/^user launch the app$/) do
end

Given(/^I register and back to login page$/) do
  steps %Q{
         When I scroll down "1" times
         Then I click "Register Text Button"
         And I fill in the form with following details
        | name                            | input                           |
        | Register Name Field             | test                            |
        | Register Email Field            | test@test.com                   |
        | Register Password Field         | 123                             |
        | Register Confirm Password Field | 123                             |

        When I scroll down "1" times
        Then I click "Register Button"
        And I wait for 1 seconds
        And I click "Register Page Login Button"
  }
end

Given(/^I input valid email and password$/) do
  steps %Q{
        When I type "test@test.com" on "Email Field"
        Then I wait for 1 seconds
        And I type "123" on "Password Field"
  }
end

And(/^I should see home page$/) do
  steps %Q{
        When I should see "iqbal"
        Then I should see "test@test.com"
        And I should see "123"
  }
end

Then(/^I should see register page$/) do
  steps %Q{
        When I should see "iqbal"
        Then I should see "test@test.com"
        And I should see "123"
  }
end

