Feature: Cards API
  As as User
  I want to use the API to manage cards
  to administrate cards operations

  Scenario: Listing cards for a project
    Given I have the cards for project "1":
      | id | title            | description                       |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
      | 3  | Take the town    | Make everybody sell their houses  |
    When I call API "/projects/1/cards"
    Then the response should be a collection of "cards" with:
      | id | title            | description                       | 
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate | 
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    | 
      | 3  | Take the town    | Make everybody sell their houses  | 

  Scenario: Get detail of a card
    Given I have the cards for project "1":
      | id | title            | description                       |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
      | 3  | Take the town    | Make everybody sell their houses  |
    When I call API "/projects/1/cards/2"
    Then the response should be a "card" with:
      | id | title            | description                       |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |

  Scenario: Creating a card
    Given I post to "/cards" for project "1" with:
      | title            | description                            |
      | Kill the Sheriff | Make the town kill the Sheriff         |
    When I call API "/projects/1/cards"
    Then the response should be a collection of "cards" with:
      | id | title            | description                       |
      | 1  | Kill the Sheriff | Make the town kill the Sheriff    |
