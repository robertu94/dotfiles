development.packages:
  pkg.installed:
    - pkgs:
      - {{pillar['packages']['gcc']}}
      - {{pillar['packages']['gdb']}}
      - {{pillar['packages']['git']}}
      - {{pillar['packages']['cscope']}}
      - {{pillar['packages']['ctags']}}
      - {{pillar['packages']['python']}}
      - {{pillar['packages']['go']}}
      - {{pillar['packages']['rust']}}
      - {{pillar['packages']['clang']}}
      - {{pillar['packages']['lldb']}}
