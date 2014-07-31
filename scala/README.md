



## Using the Scala REPL With Maven

Source:

- http://stackoverflow.com/questions/15666425/scala-repl-how-to-add-remote-maven-repository-to-scala-repl-classpath
- http://scala-tools.org/mvnsites/maven-scala-plugin/usage.html

Add `maven-scala-plugin` to your pom.xml:

    <project>
      ...
      <repositories>
        <repository>
          <id>scala-tools.org</id>
          <name>Scala-tools Maven2 Repository</name>
          <url>http://scala-tools.org/repo-releases</url>
        </repository>
      </repositories>
      ...
      <pluginRepositories>
        <pluginRepository>
          <id>scala-tools.org</id>
          <name>Scala-tools Maven2 Repository</name>
          <url>http://scala-tools.org/repo-releases</url>
        </pluginRepository>
      </pluginRepositories>
      ...
      <build>
        <sourceDirectory>src/main/scala</sourceDirectory>
        <testSourceDirectory>src/test/scala</testSourceDirectory>
        ...
        <plugins>
          ...
          <plugin>
            <groupId>org.scala-tools</groupId>
            <artifactId>maven-scala-plugin</artifactId>
            ... (see other usage or goals for details) ...
          </plugin>
          ...
        </plugins>
        ...
      </build>
      ...
    </project>

Read the help:

    mvn scala:help

Run the console/REPL:

    mvn scala:console

At DDC, this has already been done for the `web-analytics/web-ana-pixall-scalding` module:

    cd ~/git/web-analytics/web-ana-pixall-scalding
    mvn scala:console

From the console, for example, you can import and play with packages:

    scala> import com.netaporter.uri.dsl._
    scala> import com.netaporter.uri.Uri
    scala> import com.netaporter.uri.QueryString
    scala> val uriVal: Uri = null
    scala> uriVal.protocol
    java.lang.NullPointerException

