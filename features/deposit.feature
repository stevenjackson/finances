Feature:  Distribute a deposit amongst categories
  Scenario: Distributing a deposit manually
   Given I have a deposit for $300
   When I distribute the deposit
     | category  | amount |
     | groc      | 150    |
     | rent      | 150    |
   Then I should see $150 for "groc"
   And I should see $150 for "rent"

  @guard
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
