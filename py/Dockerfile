FROM python

RUN pip install requests && mkdir /data
#  Build spring app

# VOLUME [ "/data" ]
# WORKDIR /data/
ADD exploit.py /data/exploit.py
ENV target "172.17.0.2"
ENV port "8080"

CMD ["sh", "-c", "sleep 10 && python /data/exploit.py --url http://${target}:${port}/helloworld/greeting"]

