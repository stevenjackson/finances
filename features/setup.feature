Feature:  No accounts and categories at start

  @guard
  Scenario:  Add account
    When I add a new "checking" account with $100 balance
    Then I should see $100 for "checking"
