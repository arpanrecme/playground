FROM vault:1.7.2

ENV TZ=Asia/Kolkata

RUN apk add tzdata
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ >  /etc/timezone
