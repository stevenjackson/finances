Feature:  Distribute a deposit amongst categories
  Scenario: Distributing a deposit manually
   Given I have a deposit for $300
   When I distribute the deposit
     | category  | amount |
     | groc      | 150    |
     | rent      | 150    |
   Then I should see $150 for "groc"
   And I should see $150 for "rent"

  Scenario: Viewing the deposit
   Given I have a deposit for $300
   When I distribute the deposit
     | category  | amount |
     | groc      | 150    |
     | rent      | 150    |
   Then I should see the deposit:
     | category  | amount |
     | groc      | 150    |
     | rent      | 150    |

  Scenario:  Delete an item from the deposit
    Given I have a deposit for $300
    And I distribute the deposit
     | category  | amount |
     | groc      | 150    |
     | rent      | 150    |
    When I delete the credits
    Then I should see $0 for "groc"
    And I should see $0 for "rent"
