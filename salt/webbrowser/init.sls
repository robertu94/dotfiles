{% from "webbrowser/map.jinja" import webbrowser with context %}
{{ webbrowser.firefox }}:
  pkg.installed
