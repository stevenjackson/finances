Feature:  Distribute a deposit amongst categories
  Background: 
   Given I have a deposit for $300
   When I distribute the deposit
     | category  | amount |
     | groc      | 150    |
     | rent      | 150    |

  Scenario: Distributing a deposit manually
   Then I should see $150 for "groc"
   And I should see $150 for "rent"

  Scenario: Viewing the deposit
   Then I should see the deposit:
     | category  | amount |
     | groc      | 150    |
     | rent      | 150    |

  Scenario:  Delete an item from the deposit
    When I delete the credits
    Then I should see $0 for "groc"
    And I should see $0 for "rent"

  Scenario:  Change the month on the deposit
    When I apply the deposit to this month
    Then I should see $300 for deposits this month
    And I should see $0 for deposits next month

  Scenario: Defaults to deposits next month 
    Then I should see $0 for deposits this month
    And I should see $300 for deposits next month
