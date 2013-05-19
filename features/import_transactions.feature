Feature:  Import transactions from flat files

  Scenario:  Picks up files in the default directory
    Given there is a file to be imported
    Then I will see transactions
