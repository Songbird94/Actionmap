Feature: Clicking on a county in the county map should trigger the search route
  As a user
  I want to find my representative in my county


Scenario: Clicking on San Francisco county should redirect to search
  Given I am on the home page
  When I navigate to the San Francisco County in California
  Then I should be on the sf page