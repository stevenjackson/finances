Feature:  Distribute transactions amongst categories
  Scenario:  Transactions list
    Given I have a transaction for $50
    And I have a transaction for $35
    Then I should see 2 outstanding transactions

  Scenario:  Transactions can be assigned to a single category
    Given I have a budget of $100 for "groc"
    And I have a transaction for $35
    When I assign the transaction to "groc"
    Then I should see 0 outstanding transactions
    And I should see $65 for "groc"

  Scenario:  Transactions can be split
    Given I have a budget of $100 for "groc"
    And I have a budget of $15 for "gas" 
    And I have a transaction for $35
    When I split the transaction
      | category | amount |
      | groc     | 20     |
      | gas      | 15     |
    Then I should see $80 for "groc"
    And I should see $0 for "gas"

  Scenario:  Deposits don't show up in transactions view
    Given I have a deposit for $300
    Then I should see 0 outstanding transactions
