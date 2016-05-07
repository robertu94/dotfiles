desktop.packages:
  pkg.installed:
    - pkgs:
      - {{pillar['packages']['bspwm']}}
      - {{pillar['packages']['lightdm']}}
      - {{pillar['packages']['lightdm-gtk-greeter']}}
      - {{pillar['packages']['pulseaudio']}}
      - {{pillar['packages']['pulseaudio-alsa']}}
      - {{pillar['packages']['nvidia']}}
      # Specific to my panel configuration
      - {{pillar['packages']['acpi']}}
      - {{pillar['packages']['alsa-utils']}}
      - {{pillar['packages']['dmenu']}}
      - {{pillar['packages']['dunst']}}
      - {{pillar['packages']['iw']}}
      - {{pillar['packages']['libnotify']}}
      - {{pillar['packages']['mpc']}}
      - {{pillar['packages']['mpd']}}
      - {{pillar['packages']['polkit-gnome']}}
      - {{pillar['packages']['scrot']}}
      - {{pillar['packages']['ttf-dejavu']}}
      - {{pillar['packages']['xtitle-git']}}
      # Require AUR to install
      - {{pillar['packages']['lemonbar-ucs4-git']}}
      - {{pillar['packages']['hsetroot']}}
      - {{pillar['packages']['light']}}
      - {{pillar['packages']['kbdlight']}}
      - {{pillar['packages']['xtitle-git']}}

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


