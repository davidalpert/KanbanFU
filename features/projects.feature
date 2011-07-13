Feature: Projects API

  As as User
  I want to call /projects
  to get all the projects for account

  Scenario: Listing projects
    Given I have the projects:
      | id | name              | description |
      | 1  | Blazing Saddles   | To ruin a western town, a corrupt political boss appoints a black sheriff, who promptly becomes his most formidable adversary.|
      | 2  | Spaceballs        | Planet Spaceball's President Skroob sends Lord Dark Helmet to steal Planet Druidia's abundant supply of air to replenish their own, and only Lone Starr can stop them.|
      | 3  | Young Frankenstein| Dr. Frankenstein's grandson, after years of living down the family reputation, inherits granddad's castle and repeats the experiments.|
    When I call API "/projects"
    Then the JSON response should have 3 projects
    And the JSON should have the following:
      | 0 | {"id": 1, "name": "Blazing Saddles", "description": "To ruin a western town, a corrupt political boss appoints a black sheriff, who promptly becomes his most formidable adversary."} |
      | 1 | {"id": 2, "name": "Spaceballs", "description": "Planet Spaceball's President Skroob sends Lord Dark Helmet to steal Planet Druidia's abundant supply of air to replenish their own, and only Lone Starr can stop them."} |
      | 2 | {"id": 3, "name": "Young Frankenstein", "description": "Dr. Frankenstein's grandson, after years of living down the family reputation, inherits granddad's castle and repeats the experiments."} |
