echo "SSH PORTS=$SSH_PORTS"
SSH_PORT_ARGS=""
for val in $SSH_PORTS; do
    echo $val
    source="$(echo "$val" | cut -d':' -f1)"
    target="$(echo "$val" | cut -d':' -f2)"
    echo "Mapping $source -> $target"
    SSH_PORT_ARGS="$SSH_PORT_ARGS -L $target:127.0.01:$target"
    simpleproxy -d -L $source -R "127.0.0.1:$target"
done

echo "Open VPN and wait...";
openvpn --config vpn_config.ovpn &

echo "Wait for $WAIT_VPN sec";
sleep $WAIT_VPN

echo "Start SSH with port forwared";
ssh $SSH_PORT_ARGS $SSH_ARGS

echo "Closing VPN...";
id=$(ps -e | grep openvpn | awk '{print $1}');
kill -SIGINT $id
sleep 3
kill -9 $id

echo "Closing tcp proxies..."
id=$(ps -e | grep simpleproxy | awk '{print $1}')
kill -9 $id

echo "Bye Bye! Hope you enjoyed your SSH over VPN adventure (yoni)"