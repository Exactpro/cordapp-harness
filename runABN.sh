nodes="PartyA PartyB Notary"

for node in $nodes; do
    tmux new-window -n $node java -Dcapsule.jvm.args="-Xmx512m -XX:+UseG1GC" -jar build/nodes/${node}/corda.jar -b build/nodes/${node} ;\
  [ $? -eq 0 -o $? -eq 143 ] || sh
done
# '-Dname=PartyA' \
# '-Dcapsule.jvm.args=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5008 -javaagent:drivers/jolokia-jvm-1.6.0-agent.jar=port=7008,logHandlerClass=net.corda.node.JolokiaSlf4jAdapter' \
# '-jar' '/home/mz0/R3/cordapp-sample-obligation/kotlin-source/build/nodes/PartyA/corda.jar'; \
# [ $? -eq 0 -o $? -eq 143 ] || sh

#   tmux new-window -n 'PartyA-web' '/usr/lib/jvm/java-8-oracle/jre/bin/java' '-Dname=PartyA' \
# '-jar' '/home/mz0/R3/cordapp-sample-obligation/kotlin-source/build/nodes/PartyA/corda-webserver.jar'; [ $? -eq 0 -o $? -eq 143 ] || sh
