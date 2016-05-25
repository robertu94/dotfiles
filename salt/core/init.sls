{% from "core/map.jinja" import core with context %}
core.packages:
  pkg.installed:
    - pkgs:
      - {{ core.gvim }}
      - {{ core.zsh }}
      - {{ core.bash }}
