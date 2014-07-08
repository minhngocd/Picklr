Feature: Environments

  Scenario: Show all environments
    Given I have environment "qa"
    And I have environment "uat"
    And I have environment "prod"
    When I visit the features page
    Then I should see environment "qa"
    And I should see environment "uat"
    And I should see environment "prod"