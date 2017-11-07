Feature: Assignment 06, displayStandard method

    Scenario: Blank message
        When I call displayStandard with a blank message
        Then the following banner should appear on the console:
            """
            **
            **
            **
            """ 

Scenario: Single-character message
        When I call displayStandard with an "A"
        Then the following banner should appear on the console:
            """
            ***
            *A*
            ***
            """ 

Scenario: Two-character message
        When I call displayStandard with an "AB"
        Then the following banner should appear on the console:
            """
            ****
            *AB*
            ****
            """ 

Scenario: Message with spaces
        When I call displayStandard with an " A B "
        Then the following banner should appear on the console:
            """
            *******
            * A B *
            *******
            """ 