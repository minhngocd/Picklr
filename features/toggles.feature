Feature: Toggles

  Background:
    Given I have environment "qa"
    And I have feature "queue" toggled "on" for environment "qa"
    And I have feature "vatu" toggled "off" for environment "qa"

  Scenario: See all feature toggles for an environment
    When I visit the feature toggles page for environment "qa"
    Then I should see the feature "queue" is toggled "on"
    And I should see the feature "vatu" is toggled "off"

  Scenario: Request all feature toggles for an environment as json
    When I request json for all feature toggles on environment "qa"
    Then I should receive the json:
      """
      {
        "queue": true,
        "vatu": false
      }
      """

  Scenario: Request feature toggle value for an environment as json
    When I request json for feature "queue" on environment "qa"
    Then I should receive the json:
    """
    {
      "queue": true
    }
    """