{% if grains['os'] == 'Arch' %}
/etc/pacman.conf:
  file.managed:
    - source: salt://repos/pacman.conf
    - user: root
    - group: wheel
    - mode: 0644

reflector:
  pkg.installed

'reflector -c "United States" -f 3 --save /etc/mirrorlist':
  cmd.run:
    - onlyif: test $(date +%u) -eq 7

{% elif grains['os'] == 'Fedora' %}
repos.packages:
  pkg.installed:
    - sources:
      - rpmfusion-free-release: http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-{{grains['osrelease']}}.noarch.rpm
      - rpmfusion-nonfree-release: http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-{{grains['osrelease']}}.noarch.rpm
{% elif grains['os'] == 'Ubuntu' %}

{% endif %}
