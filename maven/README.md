


## Finding duplicate classes

    mvn dependency:tree

## Running without tests

    mvn -skipTests=true


## Run Tomcat Webapp Locally

    # run webapp locally, using dev environment, and skipping tests for faster startup
    env runtimeEnvironment=dev mvn -DskipTests clean package tomcat6:run


http://tomcat.apache.org/maven-plugin-trunk/tomcat6-maven-plugin/examples/deployment.html



