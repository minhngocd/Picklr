Feature: Edit Toggles

  Background:
    Given I have admin "admin@zopa.com"
    And I have environment "qa"
    And I have feature "queue" toggled "on" for environment "qa"
    And I login as "admin@zopa.com"

  Scenario:
    When I visit the feature toggles page for environment "qa"
    And I click the toggle button for "queue"
    Then I should see the feature "queue" is toggled "off"

    When I click the toggle button for "queue"
    Then I should see the feature "queue" is toggled "on"