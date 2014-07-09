Feature: Toggles

  Scenario: See all toggles for an environment
    Given I have environment "qa"
    And I have toggle "queue" turned "on" for environment "qa"
    And I have toggle "vatu" turned "off" for environment "qa"
    When I visit the toggles page for environment "qa"
    Then I should see the toggle "queue" is turned "on"
    And I should see the toggle "vatu" is turned "off"