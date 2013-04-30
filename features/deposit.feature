Feature:  Distribute a deposit amongst categories
  @wip
  Scenario: Distributing a deposit manually
   Given I have a deposit for $300
   When I distribute the deposit
     | category  | amount |
     | groc      | 150    |
     | rent      | 150    |
   Then I should see $150 for "groc"
   And I should see $150 for "rent"
