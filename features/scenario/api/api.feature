@api
Feature: REST API validation

  Background:
    Given I send and accept JSON

  Scenario: Verify end-point have a correct data-type
    When I add Headers:
      | Cache-Control | no-cache |
    And I send a GET request to "https://jsonplaceholder.typicode.com/posts"
    Then the response status should be "200"
    And the JSON response should follow "features/support/schemas/typicode.json"
    And I clear the response cache

  Scenario: Verify end-point get a correct response compare with the input data
    When I set JSON request body to:
    """
    {
      "title": "recommendation",
      "body":  "motorcycle",
      "userId": 12
    }
    """
    And  I send a POST request to "https://jsonplaceholder.typicode.com/posts"
    Then the response status should be "201"
    And  the JSON response should have "title" of type string and value "recommendation"
    And  the JSON response should have "body" of type string and value "motorcycle"
    And  the JSON response should have "userId" of type numeric and value "12"
    And I clear the response cache