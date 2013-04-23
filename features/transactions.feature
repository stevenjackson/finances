Feature:  Distribute transactions amongst categories
  Scenario:  Transactions list
    Given I have a transaction for $50
    And I have a transaction for $35
    Then I should see 2 outstanding transactions

  Scenario:  Transactions can be assigned to a single category
    Given I have a category for "groc" with an amount of $100
    And I have a transaction for $35
    When I assign the transaction to "groc"
    Then I should see 0 outstanding transactions
    And I should see $65 for "groc"

