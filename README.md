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

## Running modified net

When one wants to run a net with e.g. non-default `maxMessageSize`
he may modify `net.conf` (in this dir) and run the following commands to re-deploy nodes
(copy all the needed CorDapps following this example):

```
CorDapp1=~/.m2/repository/com/exactpro/cordapp-sample/flow10/0.0.1/flow10-0.0.1.jar
cp $CorDapp1 build/nodes/
./gradlew putBootstrapper
. newNet  # note the dot preceding newNet!
```

N.B. Default `maxMessageSize=1048576` cannot be set much higher then 10939215, otherwise you will see errors like
```
artemis.core.server.impl.ActiveMQServerImpl JournalImp
appendAddRecordTransactional:java.lang.IllegalArgumentException:
Record is too large to store 10940410
```
Note that this number is higher then our `maxMessageSize=10939396`, however lowering maxMessageSize lowers this threshold too.
