Feature: Show finances on a month basis

  Scenario:  Show category information
  Given I have a budget of $500 for "groc"
  When I have a credit for $500 in "groc" last month
  And I have a debit for $100 in "groc" this month
  Then I should see categories for this month:
    | category | budget | spent | remainder |
    | groc     | 500    | 100   | 400       |

  @guard
  Scenario:  Show account information
  Given I have a balance of $1000 for "checking" last month
  When I spend $100 from "checking" this month
  Then I should see accounts for this month:
    | account  | start  | end   | change |
    | checking | 1000   | 900   | -100   |

