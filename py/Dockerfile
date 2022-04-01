FROM python

RUN pip install requests && mkdir /data
#  Build spring app

# VOLUME [ "/data" ]
# WORKDIR /data/
ADD exploit.py /data/exploit.py
ENV target "172.17.0.2"

CMD ["sh", "-c", "python /data/exploit.py --url http://${target}:8080/helloworld/greeting"]

