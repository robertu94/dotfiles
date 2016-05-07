base:
  '*':
   - users
   - roles
   - package.defaults
  'os:Arch':
   - package.arch
  'os:Fedora':
   - package.fedora
  'os:Ubuntu':
   - package.ubuntu

