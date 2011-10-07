Feature: Cards API
  As as User
  I want to use the API to manage cards
  to administrate cards operations

  Background:
    Given I have the cards for project "1":
      | id | title            | description                       | started_on   | finished_on  | size | phase    |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate | Nov 01, 2011 | Nov 5, 2011  | 2    | archive  |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    | Nov 06, 2011 |              | 1    | working  |
      | 3  | Take the town    | Make everybody sell their houses  | Nov 10, 2011 |              | 3    | analysis |
  
  @wip
  Scenario: Listing cards for a project
    When I call API "/projects/1/cards"
    Then the response should be a collection of "cards" with:
      | id | title            | description                       | started_on   | finished_on  | size | phase    | blocked_time | waiting_time | 
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate | Nov 01, 2011 | Nov 5, 2011  | 2    | archive  | 0 | 0 |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    | Nov 06, 2011 |              | 1    | working  | 0 | 0 |
      | 3  | Take the town    | Make everybody sell their houses  | Nov 10, 2011 |              | 3    | analysis | 0 | 0 |

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
      | title                 | description                       |
      | Kill the Sheriff      | Make the town kill the Sheriff    |
    When I call API "/projects/1/cards"
    Then the response should be a collection of "cards" with:
      | id | title            | description                       |
      | 1  | Kill the Sheriff | Make the town kill the Sheriff    |

  Scenario: Updating a card
    Given I have the cards for project "1":
      | id | title            | description                       |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
      | 3  | Take the town    | Make everybody sell their houses  |
    When I put to "/cards" for project "1" and card "1" with:
      | title                 | description                       |
      | Find a Deputy         | Get a Deputy for the Sheriff      |
    And I call API "/projects/1/cards"
    Then the response should be a collection of "cards" with:
      | id | title            | description                       |
      | 1  | Find a Deputy    | Get a Deputy for the Sheriff      |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
      | 3  | Take the town    | Make everybody sell their houses  |

  Scenario: Deleting a card
    Given I have the cards for project "1":
      | id | title            | description                       |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
      | 3  | Take the town    | Make everybody sell their houses  |
    When I delete card "3" for project "1"
    And I call API "/projects/1/cards"
    Then the response should be a collection of "cards" with:
      | id | title            | description                       |
      | 1  | Find a Sheriff   | Get a Sheriff everybody will hate |
      | 2  | Kill the Sheriff | Make the town kill the Sheriff    |
