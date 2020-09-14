@web_chrome @web_firefox
Feature: Search product feature

  Scenario Outline: Verify Users able to search from searchbar
    Given I open Bukalapak page
    When I type "<search>" on "Searchbar"
    Then I should see the results of "<search>"

    Examples:
      | search     |
      | baju       |
      | celana     |
      | sepeda     |

  Scenario: User search product from item category
    Given I open Bukalapak page
    When I go to see all categories from dropdown
    Then I choose Grosir Sepeda category
    And I should have "Category Title" showing up "Kategori Grosir Sepeda"

    When I'm on the catagory page
    Then I sorting item from the cheapest
    And the first product price should be "lower" than the second product
