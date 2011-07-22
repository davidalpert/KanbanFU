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

  @wip
  Scenario: Get detail of a card
    Given I have the cards for project "1":
      | id | title            | description                       |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
      | 3  | Take the town    | Make everybody sell their houses  |
    When I call API "/projects/1/cards/2"
    Then the response should be a "card" with:
      | id          | 2                              | 
      | title       | Kill the Sheriff               |
      | description | Make the town kill the Sheriff | 
