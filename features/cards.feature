Feature: Cards API
  As as User
  I want to use the API to manage cards
  to administrate cards operations

  Scenario: Listing cards for a project
    Given I have the cards for project "1" named "Blazing Saddles":
      | id | name             | phase    | description |
      | 1  | Find a Sheriff   | Analysis | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Working  | Make the town kill the Sheriff    |
      | 3  | Take the town    | Backlog  | Make everybody sell their houses  |
    When I call API "/projects/1"
    Then the JSON response should have 3 cards
    And the JSON should have the following:
      | 0 | {"id": 1, "name": "Blazing Saddles", "description": "To ruin a western town, a corrupt political boss appoints a black sheriff, who promptly becomes his most formidable adversary."} |
      | 1 | {"id": 2, "name": "Spaceballs", "description": "Planet Spaceball's President Skroob sends Lord Dark Helmet to steal Planet Druidia's abundant supply of air to replenish their own, and only Lone Starr can stop them."} |
      | 2 | {"id": 3, "name": "Young Frankenstein", "description": "Dr. Frankenstein's grandson, after years of living down the family reputation, inherits granddad's castle and repeats the experiments."} |
