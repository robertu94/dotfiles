core.packages:
  pkg.installed:
    - pkgs:
      - {{pillar['packages']['gvim']}}
      - {{pillar['packages']['zsh']}}
      - {{pillar['packages']['bash']}}
