@ECHO off

setlocal
setx "JAVA_HOME" "C:\Progra~2\BlueJ\jdk"
set PATH=%PATH%;C:\Progra~2\BlueJ\jdk\bin

IF EXIST "first-run-done" GOTO process
rmdir "%userprofile%\.sonarlint" /s /q
type nul>first-run-done

:process
mkdir "%userprofile%\.sonarlint\conf"
copy global.json "%userprofile%\.sonarlint\conf"

rmdir feature_results /s /q

rmdir style_results /s /q
mkdir style_results

rmdir bin /s /q
mkdir bin

javac -d bin -cp "bin;." solution/*.java
javac -d bin -cp "jars/*;bin;." step_definitions/*.java

java -cp "jars/*;bin;" cucumber.api.cli.Main -p html:feature_results --snippets camelcase -g step_definitions features

call .\sonarlint\bin\sonarlint -Dsonar.java.source=1.8 -Dsonar.java.libraries="jars/*" --src "**/solution/**.java" --charset "ISO-8859-1" --html-report "style_results/stylereport.htm"
