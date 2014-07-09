Feature: Toggles

  Background:
    Given I have environment "qa"
    And I have toggle "queue" turned "on" for environment "qa"
    And I have toggle "vatu" turned "off" for environment "qa"

  Scenario: See all toggles for an environment
    When I visit the toggles page for environment "qa"
    Then I should see the toggle "queue" is turned "on"
    And I should see the toggle "vatu" is turned "off"

  Scenario: Request all toggles for an environment as json
    When I request json for all toggles on environment "qa"
    Then I should receive the json:
      """
      {
        "queue": true,
        "vatu": false
      }
      """

  Scenario: Request toggle value for an environment as json
    When I request json for toggle "queue" on environment "qa"
    Then I should receive the json:
    """
    {
      "queue": true
    }
    """