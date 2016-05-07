Dotfiles
================================================================================

This set of scripts will install and configure my dotfiles/computer setup.

This setup uses [SaltStack][salt] refer to its documentation for a description
of how SaltWorks.

Get Started
================================================================================

Deployment
--------------------------------------------------------------------------------

Follow the instructions from [SaltStack][salt] to configure the master and
minion. Then run the following commands:

```bash
#On the master
git clone https://github.com/robertu94/dotfiles
cd dotfiles
ln -s $(pwd)/salt /srv/salt
ln -s $(pwd)/pillar /srv/pillar
salt '*' saltutil.sync_grains   #if grains are undefined run this first
salt '*' state.highstate
```

Testing
--------------------------------------------------------------------------------

There are docker containers that can be used to test the configuration for
Archlinux, Ubuntu, and Fedora.  These can be found in the `testing` directory.
The makefile will create the appropriate containers:

```bash
make run_ubuntu #Create ubuntu testing enviroment
make run_fedora #Create fedora testing enviroment
make run_arch   #Create arch testing enviroment
```

On systems with Selinux, you will need to run `chcon` to allow Docker to mount the
`salt` and `pillar` directories, otherwise Docker won't be able to mount the
configurations in the containers.

Once started the build can be tested via:

```bash
cd /srv/salt
salt-call --local state.highstate
```

Salt-Ssh
--------------------------------------------------------------------------------

Salt also has an agentless mode.  To use agentless mode, edit the roster file to
contain the correct connection information for the connections.  Once edited
run:

```bash
salt-ssh '*' state.highstate
```

[salt]: https://saltstack.com/
