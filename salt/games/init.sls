{% from "games/map.jinja" import games with context %}
games.packages:
  pkg.installed:
    - pkgs:
      - {{ games.steam }}
      - {{ games.lib32_nvidia_utils }}
