@wip
Feature: Welcome
  As as early adopter of KanbanFu
  I want to see a welcome message
  explaining what this site is for.

  Scenario: First-time visitor
    When I visit the home page
    Then I should see "Welcome to KanbanFu."
     And I should see "Create a project."
