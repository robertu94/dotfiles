{% from "media/map.jinja" import media with context %}
media.packages:
  pkg.installed:
    - pkgs:
      - {{ media.vlc }}
      - {{ media.mpc }}
      - {{ media.mpd }}
      - {{ media.ncmpcpp }}
      - {{ media.gstreamer }}
      - {{ media.ffmpeg }}
      - {{ media.gst_plugins_good }}
      - {{ media.gst_plugins_bad }}
      - {{ media.gst_plugins_ugly }}
      - {{ media.gst_libav }}

