Feature: New Environment

  Background:
    Given I have admin "admin@zopa.com"
    And I have environment "qa"
    And I have feature "queue" toggled "on" for environment "qa"
    And I login as "admin@zopa.com"

  Scenario: Add new environment
    When I visit the base page
    And I click the add environment button
    Then I should be taken to the add new environment page

    When I click the create new environment button
    Then I should see error "Name can't be blank"

    When I fill out field "name" with "uat"
    And I click the create new environment button
    Then I should be taken to the feature toggles page for the "uat" environment
    And I should see the feature "queue" is toggled "off"



