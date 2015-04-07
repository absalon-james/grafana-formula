include:
  - grafana.common

libffi-dev:
  pkg.installed

libcairo-dev:
  pkg.installed

gunicorn:
  pip.installed:
    - require:
      - pkg: libffi-dev
      - pkg: libcairo-dev

graphite-api:
  pip.installed:
    - require:
      - pkg: libffi-dev
      - pkg: libcairo-dev

/etc/graphite-api.yaml:
  file.managed:
    - source: salt://grafana/graphite_api/files/graphite-api.yaml
    - template: jinja
    - user: root
    - group: root
    - mode: 600

/etc/init/graphite-api.conf:
  file.managed:
    - source: salt://grafana/graphite_api/files/graphite-api.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600

graphite-api-service:
  service.running:
    - name: graphite-api
    - enable: True
    - watch:
      - file: /etc/graphite-api.yaml
      - file: /etc/init/graphite-api.conf
    - require:
      - pip: graphite-api
      - pip: gunicorn

https://github.com/rackerlabs/blueflood.git:
  git.latest:
    - rev: master
    - target: /tmp/blueflood
    - require:
      - pkg: git

python setup.py install:
  cmd.wait:
    - cwd: /tmp/blueflood/contrib/graphite
    - watch:
      - git: https://github.com/rackerlabs/blueflood.git
    - require:
      - pkg: python-setuptools
