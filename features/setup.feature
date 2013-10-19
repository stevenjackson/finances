Feature:  No accounts and categories at start

  Scenario:  Add account
    When I add a new "checking" account with $100 balance
    Then I should see $100 for "checking"

  Scenario:  Add category
    When I add a new "rent" category with $100 budget
    Then I should see $100 for "rent"
