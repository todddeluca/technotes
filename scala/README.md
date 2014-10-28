

## Subprocesses / Subcommands

The equivalent of the python `subprocess` module is `scala.sys.process`.
http://www.scala-lang.org/api/current/index.html#scala.sys.process.package

A SO answer showing how to deal with I/O, return codes, etc:
http://stackoverflow.com/questions/6013415/how-does-the-scala-sys-process-from-scala-2-9-work

Guide to Process (the old SBT version):
http://www.scala-sbt.org/release/docs/Process.html


## Command Line Interfaces

http://stackoverflow.com/questions/8112879/scala-command-line-parser-with-subcommand-support
https://github.com/scallop/scallop
https://github.com/docopt/docopt.scala
https://github.com/scopt/scopt


## Executables / Scripts

http://raintomorrow.cc/post/50811498259/how-to-package-a-scala-project-into-an-executable-jar

For a single scala file script, you can put a shebang in the file and then run it.

File contents:

    #!/usr/bin/env scala
    // In Clock.scala

    object Clock {
      def main(args: Array[String]) = println(new java.util.Date)
    }

Run it:

    $ chmod +x Clock.scala
    $ ./Clock.scala
    Sun May 19 10:34:13 CST 2013
    Interesting

For a script with more dependencies, you can package it as a (big) jar and run it with Java:

Write a simplest build.sbt:

    import AssemblyKeys._

    assemblySettings

    jarName in assembly := "Clock.jar"

    name := "Clock"

    version := "0.1"

    scalaVersion := "2.9.1"

Test if sbt works well(the shaband line has to be removed before):

    $ sbt run
    Sun May 19 11:10:13 CST 2013
    [success] Total time: 5 s, completed May 19, 2013 11:10:13 AM

Compile code and package your jar:

    $ sbt assembly
    [info] Packaging /Users/raincole/test/target/scala-2.9.1/Clock.jar ...
    [info] Done packaging.
    [success] Total time: 7 s, completed May 19, 2013 6:20:21 PM

Now it can run on machine with only Java but not Scala.

    $ java -jar target/scala-2.9.1/Clock.jar
    Sun May 19 18:27:20 CST 2013


## JSON

There are many JSON libraries:
http://stackoverflow.com/questions/8054018/json-library-for-scala

Play-Json
https://www.playframework.com/documentation/2.2.x/ScalaJson
Support for json-path selection

Spray-Json
https://github.com/spray/spray-json
Support for conversion from Json to Scala types

Lift-Json
https://github.com/lift/lift/tree/master/framework/lift-base/lift-json/
Supports LINQ-style and XPATH-style queries

Argonaut
http://argonaut.io/
From the scalaz folks.  FP-style json



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


## Other Libraries, Etc.

Typesafe Config

https://github.com/typesafehub/config


Shapeless

https://github.com/milessabin/shapeless



SBT Revolver

https://github.com/spray/sbt-revolver

> sbt-revolver is a plugin for SBT enabling a super-fast development turnaround
> for your Scala applications.
> 
> It sports the following features:
> 
> Starting and stopping your application in the background of your interactive
> SBT shell (in a forked JVM) Triggered restart: automatically restart your
> application as soon as some of its sources have been changed Even though
> sbt-revolver works great with spray on spray-can there is nothing
> spray-specific to it. It can be used with any Scala application as long as
> there is some object with a main method.


