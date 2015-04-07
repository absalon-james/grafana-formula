saltutil.sync_all:
  salt.function:
    - tgt: {{ pillar['id'] }}

highstate:
  salt.state:
    - tgt: {{ pillar['id'] }}
    - highstate: True
    - require:
      - salt: saltutil.sync_all
