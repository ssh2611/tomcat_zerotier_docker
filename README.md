URL Shortener Tomcat Zerotier Docker
===============



```
sh build.sh
docker container start url-shortener-container-final
```

### Bash commands inside container

```
nc -l -u -p 6666

socat -u udp-recv:6666 -

sh -c "echo 'LOCAL Broadcast Test From Container 2' | socat - UDP4-DATAGRAM:172.17.255.255:6666,so-broadcast"

sh -c "echo 'REMOTE Broadcast Test From Container 2' | socat - UDP4-DATAGRAM:172.27.255.255:6666,so-broadcast"

iperf3 -s

iperf3 -c 172.27.12.188

iperf3 -c 172.17.0.1

apk add curl

curl 172.27.12.188:8080/url-shortener/shortener

curl 172.17.0.1:8080/url-shortener/shortener

```
