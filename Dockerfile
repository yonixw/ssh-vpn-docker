FROM ubuntu
RUN apt-get update && apt-get install -y openvpn
RUN apt-get install -y ssh original-awk simpleproxy
WORKDIR /vpn/config
COPY ./ssh.sh .
CMD tail -f /dev/null
