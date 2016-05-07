#!/usr/bin/env python
"""
Gather site grains for Salt Stack
"""

import itertools
import subprocess
import re

def _call(args):
    """
    Using module.run_command quietly fails when the command does
    not exist.  Since we are checking if the command exists, we would like
    to catch this.
    """
    proc = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = proc.communicate()
    ret = proc.wait()
    return ret, str(out.decode().strip()), str(err.decode().strip())


def _git_facts():
    """
    Collect facts for the git installations
    """
    try:
        ret, out, _ = _call(args=['git', '--version'])
    except OSError:
        ret = 1
    if ret == 0:
        git_version = str(out).split()[2]
    else:
        git_version = '0.0.0'

    major_version, minor_version, patch_version = [int(i) for i in git_version.split('.')[:3]]

    return {
        "git_major_version": major_version,
        "git_minor_version": minor_version,
        "git_patch_version": patch_version,
    }

def _ssh_facts():
    """
    Collect facts for the ssh installations
    """
    try:
        _, _, err = _call(args=['ssh', '-V'])
        ssh_version = str(err).split(',')[0]
        ssh_version = ssh_version[8:]
    except OSError:
        ssh_version = '0.0p0'

    try:
        major_version, minor_version, patch_version = \
                [int(i) for i in re.match(r'(\d+)\.(\d+)p(\d+)', ssh_version).groups()]
    except AttributeError:
        ssh_version = '0.0p0'
        major_version, minor_version, patch_version = (0, 0, 0)

    return {
        "ssh_version": ssh_version,
        "ssh_major_version": major_version,
        "ssh_minor_version": minor_version,
        "ssh_patch_version": patch_version,
    }

def _vim_facts():
    """
    Collect facts for the vim installations
    """
    try:
        ret, out, _ = _call(args=['vim', '--version'])
    except OSError:
        ret = -1
    if ret == 0:
        vim_version = re.match(r'^VIM - Vi IMproved (\d\.\d)', out).group(1)
        vim_major_version, vim_minor_version = [int(i) for i in  vim_version.split('.')]
    else:
        vim_version = '0.0'
        vim_minor_version = 0
        vim_major_version = 0
    return {
        "vim_version" : vim_version,
        "vim_major_version": vim_major_version,
        "vim_minor_version": vim_minor_version
    }
def _tmux_facts():
    """
    Collect facts on the tmux version installed
    """
    try:
        ret, out, _ = _call(args=['tmux', '-V'])
    except OSError:
        ret = -1
    if ret == 0:
        tmux_version = out.split()[1]
        tmux_major_version, tmux_minor_version = [int(i) for i in tmux_version.split('.')]
    else:
        tmux_version = '0.0'
        tmux_major_version, tmux_minor_version = 0, 0
    return {
        "tmux_version": tmux_version,
        "tmux_major_version": tmux_major_version,
        "tmux_minor_version": tmux_minor_version
    }


def main():
    """Gather all of the facts"""
    facts = [
        _git_facts,
        _ssh_facts,
        _vim_facts,
        _tmux_facts
    ]

    results = [fact() for fact in facts]
    return dict(itertools.chain(*[f.iteritems() for f in results]))



if __name__ == '__main__':
    main()
