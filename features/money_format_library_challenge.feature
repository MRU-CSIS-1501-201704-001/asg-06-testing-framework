Feature: Assignment 06, Money Format Library Challenge

    Scenario Outline: MoneyFormat.standard()
  Given an amount <amt>
   When I format that amount with MoneyFormat.standard, I should get <formattedAmount>
    Examples:
|  amt |formattedAmount|
|  0.0 |     "0.00"    |
| 0.114|     "0.11"    |
|-0.114|    "-0.11"    |
| 1.115|     "1.12"    |
|-1.115|    "-1.12"    |
| 1000 |   "1000.00"   |
| -1000|   "-1000.00"  |

    Scenario Outline: MoneyFormat.accounting()
  Given a width <width> and amount <amt>
   When I format that amount with MoneyFormat.accounting, I should get <formattedAmount>
    Examples:
|width|    amt    | formattedAmount|
|  1  |    0.0    |     "0.00"     |
|  1  |   0.114   |     "0.11"     |
|  1  |    0.0    |     "0.00"     |
|  1  |   -0.114  |    "(0.11)"    |
|  1  |   0.114   |     "0.11"     |
|  1  |   1.115   |     "1.12"     |
|  1  |   -1.115  |    "(1.12)"    |
|  1  |    1000   |   "1,000.00"   |
|  8  |    1000   |   "1,000.00"   |
|  9  |    1000   |   "1,000.00 "  |
|  10 |    1000   |  " 1,000.00 "  |
|  1  |   -1000   |  "(1,000.00)"  |
|  9  |   -1000   |  "(1,000.00)"  |
|  10 |   -1000   |  "(1,000.00)"  |
 