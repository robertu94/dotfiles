# Server Configurations

This repository contains a series of server configurations and files in the form
of Ansible playbooks.

## Getting Started

The ONETIME commands bootstrap the rest of the configuration by setting their values in the `.bashrc`.

```bash
# ONETIME: set the ansible vault password in a local file to access ansible-vault encrypted values
vim .vault_password
# ONETIME: tell ansible to look in the .vault_password file for the password to the vault
export ANSIBLE_VAULT_PASSWORD_FILE="./.vault_pass"
# ONETIME: set ansible_ssh_control_path to deal with 2 factor, becomes useful after the .ssh/config is configured
export ANSIBLE_SSH_CONTROL_PATH="$HOME/.ssh/.control_channels/%%h:%%p:%%r"
# ONETIME: configure the laptop to configure the .ssh/config
ansible-playbook -i inventory.ini site.yml -l laptop -t shellconfig
```

After that commands can be run like this

```bash
# logon to 2 factor machines to establish control path
ansible-playbook -i inventory.ini site.yml
```

## Inventory

Systems are divided into machines their various administrative domains.
Additionally these helper groups exist:

+ `admin` A machine that I have admin rights over
+ `work` A machine that I use for work
+ `hpc` A machine or group of machines with a home directory on a shared filesystem

## Variables

Variables are organized into:

+ `$role/defaults/main.yml` if there is a reasonable default, these tend to be laptop focused.
+ `group_vars` if something needs to be done special for a group (e.g. HPC machines with a shared filesystem and small home directories)
+ `host_vars` if something needs to be done special for a machine (e.g. path to the GPU driver libraries and architecture)
+ `group_vars/all` if it contains private information that require encryption (e.g. tokens)

## Roles

Currently this just has my dotfiles, but I would like to expand it soon include services running on my server

### Dotfiles

The dotfiles role setups all commands and configurations that I would like to
have everywhere and do not require admin access to install. Currently it configures:

+ home directory
+ editor
    + neovim
+ shell commands
    + bash+starship+fzf
    + zoxide
    + fd-find
    + du-dust
+ development tools
    + sccache
    + git+git-lfs+difftastic
    + dagger
    + gdb+mpigdb
+ package managers
    + spack
    + cargo
    + mamba

tags:

+ nvim -- setup neovim and make it useable
+ mamba -- setup mamba and make it useable
+ spack -- setup spack and make it ready to configure (spack config files are complex, holding off for now)
+ shell -- setup the shell and make it minimum viable with starship and fzf (implies shellconfig)
+ shellcmd -- setup additional shell commands
+ shellconfig -- just configuration files

# Changelog

+ 2024-03-07 -- manage dotfiles
