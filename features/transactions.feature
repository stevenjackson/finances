Feature:  Distribute transactions amongst categories
  Scenario:  Transactions list
    Given I have a transaction for $50
    And I have a transaction for $35
    Then I should see 2 outstanding transactions

