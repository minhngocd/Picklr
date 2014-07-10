Feature: Environments

  Scenario: Show all environments
    Given I have environment "qa"
    And I have environment "uat"
    And I have environment "prod"
    When I visit the base page
    Then I should see environment "qa"
    And I should see environment "uat"
    And I should see environment "prod"

  Scenario: Show environment feature toggles
    Given I have environment "qa"
    And I have environment "uat"
    When I visit the base page
    And I click the environment "qa"
    Then I should be taken to the feature toggles page for the "qa" environment