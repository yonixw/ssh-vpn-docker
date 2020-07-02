echo "Open VPN and wait...";
openvpn --config vpn_config.ovpn &

echo "Wait for $WAIT_VPN sec";
sleep $WAIT_VPN

id=$(ps -e | grep openvpn | awk '{print $1}');

echo "Start SSH";
ssh $SSH_ARGS

echo "Closing VPN...";
kill -SIGINT $id
sleep $WAIT_VPN
kill -9 $id

echo "Bye Bye! Hope you enjoyed your SSH over VPN adventure (yoni)"