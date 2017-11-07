Feature: Assignment 06, Depreciation Library Challenge

    Scenario Outline: Depreciation.straightLine()
  Given the initial cost of the asset <initialCost>
    And a residual value of the asset <residualValue> after <usefulLifeInYears>
   Then after <numYearsPassed> years have passed
   Then the total depreciation accumulated by the asset when calculated using the Straight Line method is close to <totalDepreciation>

    Examples:
|initialCost|residualValue|usefulLifeInYears|numYearsPassed|totalDepreciation|
|   100.00  |    10.00    |        10       |       1      |       9.00      |
|   100.00  |    10.00    |        10       |       2      |      18.00      |
|   100.00  |    10.00    |        10       |       9      |      81.00      |
|   100.00  |    10.00    |        10       |      10      |      90.00      |
|  1234.56  |      0      |        3        |       1      |      411.52     |
|  1234.56  |      0      |        3        |       2      |      823.04     |
|  1234.56  |      0      |        3        |       3      |     1234.56     |

    Scenario Outline: Depreciation.sumOfYearsDigits()
  Given the initial cost of the asset <initialCost>
    And a residual value of the asset <residualValue> after <usefulLifeInYears>
   Then after <numYearsPassed> years have passed
   Then the total depreciation accumulated by the asset when calculated using the Sum of Years' Digits method is close to <totalDepreciation>

    Examples:
|initialCost|residualValue|usefulLifeInYears|numYearsPassed|totalDepreciation|
|   100.00  |    10.00    |        10       |       1      |     16.3636     |
|   100.00  |    10.00    |        10       |       2      |     31.0909     |
|   100.00  |    10.00    |        10       |       9      |     88.3636     |
|   100.00  |    10.00    |        10       |      10      |     90.0000     |
|  1234.56  |      0      |        3        |       1      |      617.28     |
|  1234.56  |      0      |        3        |       2      |     1028.80     |
|  1234.56  |      0      |        3        |       3      |     1234.56     |
 