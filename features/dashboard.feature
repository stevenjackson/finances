Feature:  Show a dashboard with current financial stats
  This is an at-a-glance overview of current budget/spending information

  Scenario:  Categories should show totals
    Given  I have a category for "groc" with an amount of $100
    When I spend $60 of "groc"
    Then I should see $40 for "groc"
