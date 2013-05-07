Feature: Show finances on a month basis

  @guard
  Scenario:  Show category information
  Given I have a budget of $500 for "groc"
  When I have a credit for $500 in "groc" last month
  And I have a debit for $100 in "groc" this month
  Then I should see for this month:
    | category | budget | spent | remainder |
    | groc     | 500    | 100   | 400       |
