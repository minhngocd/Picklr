
Feature: Authorisation

  Background:
    Given I have admin "admin@zopa.com"
    And I am logged out
    And I have environment "qa"
    And I have feature "queue" toggled "on" for environment "qa"

  Scenario: Seeing the toggle button
    When I visit the feature toggles page for environment "qa"
    Then I should not see the toggle button for "queue"

    When I login as "admin@zopa.com"
    And I visit the feature toggles page for environment "qa"
    Then I should see the toggle button for "queue"

  Scenario: Seeing the add feature button
    When I visit the base page
    Then I should not see the add feature button

    When I login as "admin@zopa.com"
    And I visit the base page
    Then I should see the add feature button
