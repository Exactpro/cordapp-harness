nodes="PartyA PartyB Notary"
nodesw="PartyA PartyB"

for node in $nodes; do
    tmux new-window -n $node java -Dcapsule.jvm.args="-Xmx512m -XX:+UseG1GC" -jar build/nodes/${node}/corda.jar -b build/nodes/${node} ;\
  [ $? -eq 0 -o $? -eq 143 ] || sh
done

checkLog="build/nodes/PartyA/logs/node-$(hostname).log"
echo "monitroring '$checkLog' .."
rm -f "$checkLog"
SECONDS=0
wait1=90; step=1; count=0
echo -n "Sleeping for $wait1 seconds "
while [ $count -lt $wait1 ]; do
  echo -n "."
  sleep $step
  count=$(expr $count + $step)
 if [ -f "$checkLog" ]; then
  if grep ' started up and registered in ' "$checkLog" > /dev/null; then echo
    echo "$SECONDS seconds passed waiting for PartyA to log start & registration."
    break
  fi
 fi
done

for node in $nodesw; do
  echo "Starting webserver for $node"
  pushd build/nodes/${node}
  java -jar corda-webserver.jar &
  popd
done
sleep 50
echo "Webservers should be up and running"
