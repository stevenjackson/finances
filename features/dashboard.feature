Feature:  Show a dashboard with current financial stats
  This is an at-a-glance overview of current budget/spending information

  Scenario:  Categories show totals
    Given  I have a budget of $100 for "groc"
    When I spend $60 of "groc"
    Then I should see $40 for "groc"

  Scenario:  Accounts show totals
    Given I have a "checking" account with a balance of $100
    When I spend $20 from "checking"
    Then I should see $80 for "checking"
