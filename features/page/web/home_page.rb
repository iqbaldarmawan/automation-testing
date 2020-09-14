Given (/^I open Bukalapak page$/) do
    steps "Given I open url https://www.bukalapak.com/"
end

When (/^I go to see all categories from dropdown$/) do
    steps %Q{
    Then I click "Category Item Dropdown"
    When I click "See All Category Button"
  }
end

Then (/^I choose Grosir Sepeda category$/) do
  steps %Q{
    Then I scroll down "15" times
    And I click "Grosir Sepeda" text
  }
end


