{% from "development/map.jinja" import development with context %}
development.packages:
  pkg.installed:
    - pkgs:
      - {{ development.gcc }}
      - {{ development.gdb }}
      - {{ development.git }}
      - {{ development.cscope }}
      - {{ development.ctags }}
      - {{ development.python3 }}
      - {{ development.go }}
      - {{ development.rust }}
      - {{ development.clang }}
      - {{ development.lldb }}
