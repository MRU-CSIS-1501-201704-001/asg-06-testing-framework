package step_definitions;

import static org.junit.Assert.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.contentOf;

import java.io.ByteArrayOutputStream;
import java.io.ByteArrayInputStream;
import java.io.PrintStream;
import java.io.File;
import java.util.Arrays;
import java.util.Queue;
import java.util.LinkedList;
import java.util.regex.Matcher;

import cucumber.api.java.en.*;
import cucumber.api.java.Before;
import cucumber.api.java.After;
import cucumber.api.Scenario;
import cucumber.api.PendingException;

import java.util.regex.Pattern;


public class DiceLibraryChallengeSteps {
    
    public static int NUM_DIE_ROLLS = 10_000;

    private LinkedList<String> inputQueue = new LinkedList<>();
    private String[] outputLines;
    private int nextLine;

    private String dieFaces;
    private int numDiceRolled;

    @Before
    public void beforeCallingScenario() {
    }

	
    @After
    public void afterRunningScenario(Scenario scenario) {
        this.inputQueue.clear();
        this.outputLines = null;
        this.nextLine = -1;
    }

    public void provideKeyboardInput() {
        String queuedInput = "";
        for (String s : inputQueue) {
            queuedInput += String.format("%s%n",s);
        }
        System.setIn(new ByteArrayInputStream(queuedInput.getBytes()));
    }


    @Given("^faces \"([^\"]*)\"$")
    public void faces(String givenDieFaces) throws Throwable {
        this.dieFaces = givenDieFaces;
    }
    

    @Then("^the probability of rolling \"([^\"]*)\" should be close to (\\d+) out of (\\d+)$")
    public void theProbabilityOfRollingShouldBeCloseToOutOf(String face, int a, int b) throws Throwable {
        int numTimesThrown = 0;
        for (int i = 0; i < NUM_DIE_ROLLS; i++) {
            String rolledFace = (String)Class.forName("Dice").getMethod("roll", String.class).invoke(null, this.dieFaces);
            if (rolledFace.equals(face)) {
                numTimesThrown++;
            }
        }
        double expectedOdds = (double)a  / b;
        double actualOdds = numTimesThrown / (double)NUM_DIE_ROLLS;
        double epsilon =  Math.abs(expectedOdds - actualOdds);
        if (epsilon > 0.1) {
            throw new AssertionError("Exected something close to " + a + " out of " + b + ", but instead got " + actualOdds);
        }
    }

    @Given("^numRolled (\\d+)$")
    public void numrolled(int numDiceRolled) throws Throwable {
        this.numDiceRolled = numDiceRolled;
    }
    
    @Then("^the average sum should be (.+)$")
    public void theAverageSumShouldBe(double expectedAvg) throws Throwable {
        int sum = 0;
        for (int i = 0; i < NUM_DIE_ROLLS; i++) {
            sum += (int)Class.forName("Dice").getMethod("sum", String.class, int.class).invoke(null, this.dieFaces, this.numDiceRolled);
        }
        double actualAvg = sum / (double)NUM_DIE_ROLLS;
        double epsilon = Math.abs(actualAvg - expectedAvg);
        if (epsilon > 0.1) {
            throw new AssertionError("Exected something close to " + expectedAvg + ", but instead got " + actualAvg);
        }
    }


    public void runDisplayPaddedWith(String msg, int padding) throws Throwable {
        ByteArrayOutputStream outContent = null;
        PrintStream testSystemOut = null;
        try {
            outContent = new ByteArrayOutputStream();
            testSystemOut = new PrintStream(outContent, true, "UTF-8");

            PrintStream originalSystemOut = System.out;
            try {
                System.setOut(testSystemOut);

                provideKeyboardInput();
                Class.forName("Banner").getMethod("displayPadded", String.class, int.class).invoke(null, msg, padding);
            } finally {
                System.setOut(originalSystemOut);
            }

            testSystemOut.flush();
            outputLines = outContent.toString("UTF-8").split("\\R+");
            nextLine = 0;
        } finally {
            testSystemOut.close();
            outContent.close();
        }
    }


    public void runDisplayStandardWith(String msg) throws Throwable {
        ByteArrayOutputStream outContent = null;
        PrintStream testSystemOut = null;
        try {
            outContent = new ByteArrayOutputStream();
            testSystemOut = new PrintStream(outContent, true, "UTF-8");

            PrintStream originalSystemOut = System.out;
            try {
                System.setOut(testSystemOut);

                provideKeyboardInput();
                Class.forName("Banner").getMethod("displayStandard", String.class).invoke(null,msg);
            } finally {
                System.setOut(originalSystemOut);
            }

            testSystemOut.flush();
            outputLines = outContent.toString("UTF-8").split("\\R+");
            nextLine = 0;
        } finally {
            testSystemOut.close();
            outContent.close();
        }
    }
          

    public void assertRemainingOutputIsEmpty() throws Throwable {
        if (this.nextLine != this.outputLines.length) {
            throw new AssertionError("Expected no output, but there was output.");
        }
    }
    

    public void assertEntireOutputIsExactly(String expectedOutput) throws Throwable {
        String[] expectedChunked = expectedOutput.split("\\R+");
        int expectedOutputLength = expectedChunked.length;
        int actualOutputLength = outputLines.length;

        if (actualOutputLength != expectedOutputLength) {
            throw new AssertionError("Expected output to be " + expectedOutputLength + " lines long, but it was " + actualOutputLength + " lines instead.");
        }

        for (int i = 0; i < expectedOutputLength; i++) {
            String expectedLine = expectedChunked[i];
            String actualLine = outputLines[i];
            if (!actualLine.equals(expectedLine)) {
                String msg = String.format("%nLine %02d is %n%s%n but expected %n%s%n", i, actualLine, expectedLine);
                throw new AssertionError(msg);
            }
        }
    }

    public void assertRemainingOutputContainsFragment(String word) throws Throwable {
        this.assertRemainingOutputContains(word, "\"" + word + "\"");
    }

    public void assertRemainingOutputContainsWord(String word) throws Throwable {
        this.assertRemainingOutputContains("\\b" + word + "\\b", "word \"" + word + "\"");
    }

    public void assertRemainingOutputContains(String regex, String niceName) throws Throwable {

        int lineToCheck = this.nextLine;
        boolean found = false;


        System.err.println(regex);

        regex = regex.replaceAll("[-.\\+*?\\[^\\]$(){}=!<>|:\\\\]", "\\\\$0");
        while (!found && lineToCheck < this.outputLines.length) {
            Pattern p = Pattern.compile(regex);
            Matcher m = p.matcher(this.outputLines[lineToCheck]);
            found = m.find();

            lineToCheck++;
        }

        if (found) {
            this.nextLine = lineToCheck;
        } else {
            throw new AssertionError("Could not find " + niceName + " in remaining lines:\n" +
                String.join("\n", Arrays.copyOfRange(this.outputLines, this.nextLine, this.outputLines.length)) +
                (this.nextLine > 0 ? "\nPrevious line was:\n" + this.outputLines[this.nextLine - 1] : ""));
        }
    }

    public void assertRemainingOutputMissingWord(String word) throws Throwable {
        this.assertRemainingOutputMissing("\\b" + word + "\\b", word);
    }

    public void assertRemainingOutputMissing(String regex, String niceName) throws Throwable {
        int lineToCheck = this.nextLine;
        boolean found = false;

        regex = regex.replaceAll("[-.\\+*?\\[^\\]$(){}=!<>|:\\\\]", "\\\\$0");
        while (!found && lineToCheck < this.outputLines.length) {
            Pattern p = Pattern.compile(regex);
            Matcher m = p.matcher(this.outputLines[lineToCheck]);
            found = m.find();

            lineToCheck++;
        }

        if (found) {
            throw new AssertionError("Did not expect to find '" + regex + "', but found it in the line:\n" +
                String.join("\n", this.outputLines[lineToCheck - 1]));
        }
    }
    
}
