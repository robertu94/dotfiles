{% from "server/map.jinja" import server with context %}

server.packages:
  pkg.installed:
    - pkgs:
      - {{ server.tmux }}
      - {{ server.procps_ng }}
      - {{ server.htop }}
      - {{ server.iotop }}
      - {{ server.terminus_font }}
      - {{ server.openssh }}
sshd:
  service.running:
    - enable: True

{% set filelist = {'vconsole.conf':'/etc/vconsole.conf','sshd_config':'/etc/ssh/sshd_config'} %}
{% for file_name, file_path in filelist.iteritems() %}
{{file_path}}:
  file.managed:
    - owner: root
    - group: wheel
    - mode: 0644
    - template: jinja
    - source: salt://server/{{file_name}}
{% endfor %}
