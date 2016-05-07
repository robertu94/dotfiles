base:
 '*':
   - dotfiles

 'I@role:desktop or I@role:server':
   - match: compound
   - repos
   - core
   - unattended

 'role:desktop':
   - match: pillar
   - desktop
   - development
   - media
   - webbrowser
   - games

 'role:server':
   - match: pillar
   - server
