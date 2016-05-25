{% from "desktop/map.jinja" import desktop with context %}
desktop.packages:
  pkg.installed:
    - pkgs:
      - {{ desktop.bspwm }}
      - {{ desktop.lightdm }}
      - {{ desktop.lightdm_gtk_greeter }}
      - {{ desktop.pulseaudio }}
      - {{ desktop.pulseaudio_alsa }}
      - {{ desktop.nvidia }}
      # Specific to my panel configuration
      - {{ desktop.acpi }}
      - {{ desktop.alsa_utils }}
      - {{ desktop.dmenu }}
      - {{ desktop.dunst }}
      - {{ desktop.iw }}
      - {{ desktop.libnotify }}
      - {{ desktop.mpc }}
      - {{ desktop.mpd }}
      - {{ desktop.polkit_gnome }}
      - {{ desktop.scrot }}
      - {{ desktop.ttf_dejavu }}
      # Require AUR to install
      - {{ desktop.lemonbar }}
      - {{ desktop.hsetroot }}
      - {{ desktop.light }}
      - {{ desktop.kbdlight }}
      - {{ desktop.xtitle }}

{% for user in pillar['users'] %}
/home/{{user}}/.config:
  file.recurse:
    - source: salt://desktop/config
    - user: {{user}}
    - group: {{user}}

/home/{{user}}/.local/bin:
  file.recurse:
    - source: salt://desktop/scripts
    - user: {{user}}
    - group: {{user}}
{% endfor %}


