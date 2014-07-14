Feature: New Feature

  Background:
    Given I have admin "admin@zopa.com"
    And I have environment "qa"
    And I have environment "uat"
    And I have feature "queue" toggled "on" for environment "qa"
    And I login as "admin@zopa.com"

  Scenario: Add new toggle
    When I visit the base page
    And I click the add feature button
    Then I should be taken to the add new feature page

    When I click the create new feature button
    Then I should see error "Name can't be blank"
    And I should see error "Display name can't be blank"

    When I fill out field "name" with "new_feature"
    And I fill out field "display name" with "New Feature"
    And I click the create new feature button
    Then I should be taken to the edit toggle values page for feature "new_feature"

    When I visit the feature toggles page for environment "qa"
    Then I should see the feature "new_feature" is toggled "off"



