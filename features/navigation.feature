Feature: Navigation
  Scenario:  Navigate to previous month
    Given I am viewing the May dashboard
    Then I should be able to navigate to the previous April dashboard

  Scenario:  Navigate to next month
    Given I am viewing the May dashboard
    Then I should be able to navigate to the next June dashboard

  Scenario:  Navigate to previous year
    Given I am viewing the January dashboard
    Then I should be able to navigate to the previous December dashboard

  Scenario:  Navigate to next year
    Given I am viewing the December dashboard
    Then I should be able to navigate to the next January dashboard

  Scenario:  Navigate to unsorted transactions
    Given I have unsorted transactions for "checking"
    Then I can get to "checking" transactions from the dashboard

  Scenario: Navigate to expenses
    Given I have some expenses
    Then I can get to the expenses view from the dashboard

  Scenario: Navigate to income
    Given I have some deposits
    Then I can get to the income view from the dashboard
