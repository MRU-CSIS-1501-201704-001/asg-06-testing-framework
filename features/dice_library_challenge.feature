Feature: Assignment 06, Dice Library Challenge

    Scenario Outline: Desired results for Dice.roll()
  Given faces <faces>
   Then the probability of rolling <face> should be close to <a> out of <b>

    Examples:
|  faces |face|a|b|
|   "1"  | "1"|1|1|
|   "1"  | "2"|0|1|
|  "12"  | "1"|1|2|
|  "12"  | "2"|1|2|
|  "12"  | "0"|0|1|
|  "1xx" | "1"|1|3|
|  "1xx" | "x"|2|3|
|"1xxaaa"| "1"|1|6|
|"1xxaaa"| "x"|2|6|
|"1xxaaa"| "a"|3|6|

    Scenario Outline: Desired results for Dice.sum()
  Given faces <faces>
    And numRolled <numRolled>
   Then the average sum should be <avgSum>

    Examples:
| faces|numRolled|avgSum|
|  "1" |    0    |  0.0 |
|  "1" |    1    |  1.0 |
|  "1" |    2    |  2.0 |
| "12" |    0    |  0.0 |
| "12" |    1    |  1.5 |
| "12" |    2    |  3.0 |
| "12" |    3    |  4.5 |
|"1233"|    0    |  0.0 |
|"1233"|    1    | 2.25 |
|"1233"|    2    |  4.5 |
|"1233"|    3    | 6.75 |
 