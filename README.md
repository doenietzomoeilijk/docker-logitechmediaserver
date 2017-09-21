Overview
========

Docker image for Logitechmediaserver (7.9.1).

Building
========

```docker build -t <username>/logitechmediaserver```

Running
=======

* The image exposes Logitechmediaserver ports 9000, 9090, 3483 and 9001 (supervisord).

Example run command:
```docker -d -p 9000:9000 -p 9090:9090 -p 3483:3483 -p 9001:9001 -v /your/media:/media tdeckers/logitechmediaserver```
