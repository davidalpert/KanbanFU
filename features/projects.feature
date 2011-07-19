Feature: Projects API
  As as User
  I want to call /projects
  to get all the projects for account

@wip
  Scenario: Listing projects
    Given I have the projects:
      | id | name              | description |
      | 1  | Blazing Saddles   | To ruin a western town, a corrupt political boss appoints a black sheriff, who promptly becomes his most formidable adversary.|
      | 2  | Spaceballs        | Planet Spaceball's President Skroob sends Lord Dark Helmet to steal Planet Druidia's abundant supply of air to replenish their own, and only Lone Starr can stop them.|
      | 3  | Young Frankenstein| Dr. Frankenstein's grandson, after years of living down the family reputation, inherits granddad's castle and repeats the experiments.|
    When I call API "/projects"
    Then the response should be a collection of "projects" with:
    | id | name              | description |
    | 1  | Blazing Saddles   | To ruin a western town, a corrupt political boss appoints a black sheriff, who promptly becomes his most formidable adversary.|
    | 2  | Spaceballs        | Planet Spaceball's President Skroob sends Lord Dark Helmet to steal Planet Druidia's abundant supply of air to replenish their own, and only Lone Starr can stop them.|
    | 3  | Young Frankenstein| Dr. Frankenstein's grandson, after years of living down the family reputation, inherits granddad's castle and repeats the experiments.|
