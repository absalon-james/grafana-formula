Description
===========
Formula to deploy elastic search, graphite-api, nginx, and grafana to single machine.

Sample Pillar Data
==================
```yaml
es_version: 1.3.4
es_hash: 3d9e3a30481270179eab8fc093bc2569
gr_version: 1.8.1
gr_hash: 7019fc7c9e5a7bbbf992fbb4f22779c9
grafanizer_branch: warnings

graphite_api_warning:
  url: https://github.com/absalon-james/graphite_api_warning.git
  rev: master
  target: /root/graphite_api_warning
  python_path: /usr/local/lib/python2.7/dist-packages

graphite_api:
  gunicorn:
    worker_timeout: 240

blueflood:
  rev: master
  target: /tmp/blueflood

nginx:
  graphite:
    proxy_read_timeout: 240
```
