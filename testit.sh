PATH="/Applications/BlueJ.app/Contents/JDK/Home/bin:$PATH"

SCRIPT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd )

# ensure SonarLint global configuration is setup
mkdir -p ~/.sonarlint/conf
cp "${SCRIPT_PATH}/global.json" ~/.sonarlint/conf

# clean up old runs
rm -rf "${SCRIPT_PATH}/feature_results"
rm -rf "${SCRIPT_PATH}/style_results"
rm -rf "${SCRIPT_PATH}/bin"

mkdir "${SCRIPT_PATH}/bin"
javac -d "${SCRIPT_PATH}/bin" "${SCRIPT_PATH}/solution"/*.java
javac -d "${SCRIPT_PATH}/bin" -cp "${SCRIPT_PATH}/jars/*:${SCRIPT_PATH}/bin" "${SCRIPT_PATH}/step_definitions"/*.java

java -cp "${SCRIPT_PATH}/jars/*:${SCRIPT_PATH}/bin" cucumber.api.cli.Main -p "html:${SCRIPT_PATH}/feature_results" --snippets camelcase -g step_definitions "${SCRIPT_PATH}/features"

chmod a+x "${SCRIPT_PATH}/sonarlint/bin/sonarlint"
pushd "${SCRIPT_PATH}"
"${SCRIPT_PATH}/sonarlint/bin/sonarlint" -Dsonar.java.source=1.8 -Dsonar.java.libraries="${SCRIPT_PATH}/jars/*" --src "${SCRIPT_PATH}/solution/**" --charset "ISO-8859-1" --html-report "${SCRIPT_PATH}/style_results/stylereport.html"
rm -rf "${SCRIPT_PATH}/.sonarlint"
popd
