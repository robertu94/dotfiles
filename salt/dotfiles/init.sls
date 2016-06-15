#Copy dotfiles
{% for user in pillar['users'] %}
#copy dotfiles
/home/{{user}}:
  file.recurse:
    - source: salt://dotfiles/templates
    - user: {{user}}
    - group: {{user}}
    - file_mode: 0600
    - template: jinja

#copy scripts
/home/{{user}}/.local:
  file.recurse:
    - source: salt://dotfiles/scripts
    - user: {{user}}
    - group: {{user}}
    - file_mode: 0700
    - template: jinja

#bootstrap vundle
Vundle Bootstrap {{user}}:
  git.latest:
    - name: https://github.com/VundleVim/Vundle.vim/
    - target: /home/{{user}}/.vim/bundle/Vundle.vim
    - user: {{user}}

{% endfor %}
