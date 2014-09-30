


## Finding duplicate classes

    mvn dependency:tree

## Running without tests

    mvn -skipTests=true


## Run a specific test

http://maven.apache.org/surefire/maven-surefire-plugin/examples/single-test.html

Running a Single Test

    mvn -Dtest=TestCircle test

The value for the test parameter is the name of the test class (without the extension; we'll strip off the extension if you accidentally provide one).

You may also use patterns to run a number of tests:

    mvn -Dtest=TestCi*le test

And you may use multiple names/patterns, separated by commas:

    mvn -Dtest=TestSquare,TestCi*le test

## Run Tomcat Webapp Locally

    # run webapp locally, using dev environment, and skipping tests for faster startup
    env runtimeEnvironment=dev mvn -DskipTests clean package tomcat6:run


http://tomcat.apache.org/maven-plugin-trunk/tomcat6-maven-plugin/examples/deployment.html




