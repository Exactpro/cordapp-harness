# sometimes a node is "skipped". Or two. How comes!?

egrep -o 'name\s+\"[^\"]+\"' build.gradle | grep -o "O=[^,]*," |sed 's/O=//;s/,//' |\
while read node; do
    tmux new-window -n "$node" \
    java -Dcapsule.jvm.args="-Xmx4G -XX:+UseG1GC -Dlog4j.configurationFile=nlog4j.xml" \
     -jar "build/nodes/${node}/corda.jar" \
     --no-local-shell \
     --logging-level=INFO \
     -b "build/nodes/${node}" ;\
  [ $? -eq 0 -o $? -eq 143 ] || sh
done

# '-Dname=PartyA' \
# '-Dcapsule.jvm.args=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5008 -javaagent:drivers/jolokia-jvm-1.6.0-agent.jar=port=7008,logHandlerClass=net.corda.node.JolokiaSlf4jAdapter' \
# '-jar' '<projectdir>/build/nodes/PartyA/corda.jar'; \
# [ $? -eq 0 -o $? -eq 143 ] || sh

#   tmux new-window -n 'PartyA-web' 'java' '-Dname=PartyA' \
# '-jar' '<projectdir>/build/nodes/PartyA/corda-webserver.jar'; [ $? -eq 0 -o $? -eq 143 ] || sh
