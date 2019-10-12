# A CorDapp Runner

This harness runs a pre-built Cordapp named in line 11 of the build.gradle
```
        testCordapp1 = "com.r3.corda:corda-ptflows:4.2"
```
against CE 4.2 on a single local node.

## Running

* Ensure CE 4.2 in mavenLocal, see ENT-3952 for instruction.
* Make a node Notary1
* Start it
* Start a flow in the node's interactive shell
```
./gradlew clean deployNodes

# in tmux
. runN.sh

# tmux opens a new window named Notary1; wait for >>> prompt, and issue this command:

start LinearStateBatchNotariseFlow notary: "Notary1", n: 50, x: 13, logIterations: yes, transactionsPerSecond: 15


# or (switch tmux window back; hit Enter on password prompt)

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  -p 10004 userN@localhost \
start LinearStateBatchNotariseFlow notary: "Notary1", n: 50, x: 13, logIterations: yes, transactionsPerSecond: 15
```

## References

[LinearStateBatchNotariseFlow](https://github.com/corda/enterprise/blob/release/ent/4.3/perftestcordapp/src/main/kotlin/com/r3/corda/enterprise/perftestcordapp/flows/LinearStateBatchNotariseFlow.kt)

[CQA-143 re:NotaryPerf - Add LinearStateBatchNotariseFlow](https://r3-cev.atlassian.net/browse/CQA-143)
