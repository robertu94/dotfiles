media.packages:
  pkg.installed:
    - pkgs:
      - {{pillar['packages']['vlc']}}
      - {{pillar['packages']['mpc']}}
      - {{pillar['packages']['mpd']}}
      - {{pillar['packages']['ncmpcpp']}}
      - {{pillar['packages']['ffmpeg']}}
      - {{pillar['packages']['gst-plugins-good']}}
      - {{pillar['packages']['gst-plugins-bad']}}
      - {{pillar['packages']['gst-plugins-ugly']}}
      - {{pillar['packages']['gst-libav']}}
      - {{pillar['packages']['gstreamer']}}
