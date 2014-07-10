Feature: Authentication and Authorisation

  Scenario: User login
    Given I have admin "admin@zopa.com"
    And I am logged out
    When I visit the base page
    Then I should see the login link
    And I should not see the logout link
    And I should not see "Logged in as admin@zopa.com"

    When I visit the base page
    And I login as "admin@zopa.com"
    Then I should see "Logged in as admin@zopa.com"
    And I should see the logout link
    And I should not see the login link
