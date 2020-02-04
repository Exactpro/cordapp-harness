# A CorDapp Runner

This harness runs a pre-built Cordapp named in line 22 of the build.gradle
```
        testCordapp1 = "ggg:aaa:v.v"
```
against CE 4.3 on a number of local nodes.

## Running

* Ensure testCordapp1 in mavenLocal
* R3 artifactory login in .secret OR artifacts in mavenLocal
* ./gradlew deployN - build nodes & local network in build/nodes
* (in tmux) ./runN2.sh - run all nodes
