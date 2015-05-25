# A Ruby Development environment based on Ruby on Rails devbox

## Introduction

This project automates the setup of a development environment for Ruby ecosystem. This is the easiest way to build a box with everything ready to start hacking, all in an isolated virtual machine.

## Requirements

* [VMWare Fusion](http://www.vmware.com/products/fusion)
* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://vagrantup.com)

**I recommend you to download the tarball available in the dist folder, the file includes this repo with all git submodules, so your host machine won't need even `git`**

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ tar -xvzf brotodevbox-2.0.0.tar.gz
    host $ cd brotodevbox
    host $ vagrant up

That's it.

If the base box is not present that command fetches it first. The setup itself takes about 6 minutes in my MacBook Retina 13". After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh
    Welcome to Ubuntu 14.04 (GNU/Linux 3.16.0-29-generic x86_64)
    ...
    using system at ~
    $

Port 3000 in the host computer is forwarded to port 3000 in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:3000 in the host computer.

## What's In The Box

- GIT
- Ruby 1.9.3 [Ubuntu package]
- rbenv
- ruby\_build
- PostgreSQL 9.3
- MySQL 5.6
- Open JDK 7 Headless
- Elasticsearch
- Heroku Toolbelt
- System dependencies for nokogiri, ruby, rmagick, sqlite3, mysql, mysql2, and pg
- Memcached
- [dotfiles](https://github.com/brennovich/dotfiles)

## Recommended Workflow

The recommended workflow is

* edit in the host computer and
* test within the virtual machine.

Vagrant is configured to mount your ~/code folder within the virtual machine:

    using system at ~
    $ ls
    code

This workflow is convenient because in the host computer one normally has his editor of choice fine-tuned, and other graphic tools configured.

Probably you want to put your SSH keys into a folder `.ssh` inside the shared folder `code`. The vangrant and the dotfiles will automatically forward SSH sessions and add a new identity, so you be able to push to Github with your existing key ;)

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://vagrantup.com/v1/docs/index.html) for more information on Vagrant.
