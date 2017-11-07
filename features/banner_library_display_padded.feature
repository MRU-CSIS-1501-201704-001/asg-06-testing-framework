Feature: Assignment 06, displayPadded method

    Scenario: Blank message, 0 padding
        When I call displayPadded with a blank message and padding 0
        Then the following banner should appear on the console:
            """
            **
            **
            **
            """ 

    Scenario: Blank message, 1 padding
        When I call displayPadded with a blank message and padding 1
        Then the following banner should appear on the console:
            """
            ****
            *  *
            *  *
            *  *
            ****
            """ 

    Scenario: Blank message, 2 padding
        When I call displayPadded with a blank message and padding 2
        Then the following banner should appear on the console:
            """
            ******
            *    *
            *    *
            *    *
            *    *
            *    *
            ******
            """ 

Scenario: Single-character message, 0 padding
        When I call displayPadded with an "A" and padding 0
        Then the following banner should appear on the console:
            """
            ***
            *A*
            ***
            """ 

Scenario: Single-character message, 1 padding
        When I call displayPadded with an "A" and padding 1
        Then the following banner should appear on the console:
            """
            *****
            *   *
            * A *
            *   *
            *****
            """ 

Scenario: Single-character message, 2 padding
        When I call displayPadded with an "A" and padding 2
        Then the following banner should appear on the console:
            """
            *******
            *     *
            *     *
            *  A  *
            *     *
            *     *
            *******
            """ 

Scenario: Four-character message, 0 padding
        When I call displayPadded with an "A b " and padding 0
        Then the following banner should appear on the console:
            """
            ******
            *A b *
            ******
            """ 

Scenario: Four-character message, 1 padding
        When I call displayPadded with an "A b " and padding 1
        Then the following banner should appear on the console:
            """
            ********
            *      *
            * A b  *
            *      *
            ********
            """ 

Scenario: Four-character message, 2 padding
        When I call displayPadded with an "A b " and padding 2
        Then the following banner should appear on the console:
            """
            **********
            *        *
            *        *
            *  A b   *
            *        *
            *        *
            **********
            """ 