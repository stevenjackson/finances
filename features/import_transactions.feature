Feature:  Import transactions from flat files
  @guard
  Scenario:  Picks up files in the default directory
    Given there is a file to be imported
    When I wait long enough for it to be imported
    Then I will see transactions
