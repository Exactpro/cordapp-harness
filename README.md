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

# or with an rpc-client [3]
RPCclient="java -jar build/libs/rpc-client-ent42.jar"
notary="localhost:10002 userN z"
notar2="localhost:10022 userN x"

$RPCclient run $notary LinearStateBatchNotariseFlow "notary: Notář, n: 51, x: 13, logIterations: yes, transactionsPerSecond: 15"

# or use an unambigiously abbreviated flow name (note that space and comma necessitate quotes, either single or double)
$RPCclient run $notary BatchNotarise "notary: Notář, n: 51, x: 2, logIterations: no, transactionsPerSecond: 85"
$RPCclient run $notar2 BatchNota "notary: 'Notar 1', n: 51, x: 2, logIterations: no, transactionsPerSecond: 85"
$RPCclient run $notary BatchN "notary: \"Notary1\", n: 51, x: 13, logIterations: no, transactionsPerSecond: 15"
$RPCclient run $notary Ba "notary: 'O=Notář,L=Prague,C=CZ', n: 51, x: 2, logIterations: no, transactionsPerSecond: 85"

```

## References

[LinearStateBatchNotariseFlow](https://github.com/corda/enterprise/blob/release/ent/4.3/perftestcordapp/src/main/kotlin/com/r3/corda/enterprise/perftestcordapp/flows/LinearStateBatchNotariseFlow.kt)

[CQA-143 re:NotaryPerf - Add LinearStateBatchNotariseFlow](https://r3-cev.atlassian.net/browse/CQA-143)

[commit 065ae57](https://github.com/mz0/corda-rpc-client/tree/065ae57)
