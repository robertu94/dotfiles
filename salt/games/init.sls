games.packages:
  pkg.installed:
    - pkgs:
      - {{pillar['packages']['steam']}}
      - {{pillar['packages']['lib32-nvidia-utils']}}
