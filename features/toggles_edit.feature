Feature: Edit Toggles

  Background:
    Given I have admin "admin@zopa.com"
    And I have environment "qa"
    And I have environment "uat"
    And I have feature "queue" toggled "on" for environment "qa"
    And I login as "admin@zopa.com"

  Scenario: Edit toggle values for given environment
    When I visit the feature toggles page for environment "qa"
    And I click the toggle button for "queue"
    Then I should see the feature "queue" is toggled "off"

    When I click the toggle button for "queue"
    Then I should see the feature "queue" is toggled "on"

  Scenario: Edit toggle value for all environments
    When I visit the edit toggle values page for feature "queue"
    Then I should see a "checked" checkbox for "qa"
    And I should see a "unchecked" checkbox for "uat"

    When I uncheck the checkbox for "qa"
    And I check the checkbox for "uat"
    And I click the complete feature edit button
    Then I should be taken to the base features page
    And I should see notice "Feature updated"

    When I visit the feature toggles page for environment "qa"
    Then I should see the feature "queue" is toggled "off"

    When I visit the feature toggles page for environment "uat"
    Then I should see the feature "queue" is toggled "on"
