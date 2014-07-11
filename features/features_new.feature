Feature: New Feature

  Background:
    Given I have admin "admin@zopa.com"
    And I have environment "qa"
    And I have environment "uat"
    And I have feature "queue" toggled "on" for environment "qa"
    And I login as "admin@zopa.com"

  Scenario: Add new toggle


