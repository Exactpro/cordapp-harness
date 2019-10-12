# A CorDapp Runner

This CorDapp runs a pre-built Cordapp named in line 12 of the build.gradle
```
        testCordapp1 = "com.r3.corda:corda-ptflows:4.2"
```
against net.corda-4.1 on a single node local.

## Running

* Make one node: Notary1.
* Start it
* Start a flow in an intreactive shell.
```
./gradlew clean deployNodes

# in tmux
. runN.sh

# switch to the window labeled Notary1 and issue this command:
start LinearStateBatchNotariseFlow notary: "Notary1", n: 50, x: 13, logIterations: yes, transactionsPerSecond: 15
```

## References

[LinearStateBatchNotariseFlow](https://github.com/corda/enterprise/blob/release/ent/4.3/perftestcordapp/src/main/kotlin/com/r3/corda/enterprise/perftestcordapp/flows/LinearStateBatchNotariseFlow.kt)

[CQA-143 re:NotaryPerf - Add LinearStateBatchNotariseFlow](https://r3-cev.atlassian.net/browse/CQA-143)
