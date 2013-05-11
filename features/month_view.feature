Feature: Show finances on a month basis

  Scenario:  Show category information
    Given I have a budget of $500 for "groc"
    When I have a credit for $500 in "groc" last month
    And I have a debit for $100 in "groc" this month
    Then I should see categories for this month:
      | category | budget | spent | remainder |
      | groc     | 500    | 100   | 400       |

  Scenario:  Show account information
    Given I have a balance of $1000 for "checking" last month
    When I spend $100 from "checking" this month
    Then I should see accounts for this month:
      | account  | start  | end   | change |
      | checking | 1000   | 900   | -100   |

  Scenario:  Show totals
    Given I have a budget of $500 for "groc"
    And I have a budget of $1000 for "rent"
    And I have a credit for $500 in "groc" last month
    And I have a debit for $100 in "groc" this month
    And I have a credit for $1000 in "rent" last month
    Then I should see $1500 for deposits this month
    And I should see $100 for expenses this month
