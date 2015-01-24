# A Development environment based on Ruby on Rails devbox

## Introduction

This project automates the setup of a development environment for Ruby ecosystem. This is the easiest way to build a box with everything ready to start hacking, all in an isolated virtual machine.

## Requirements

* [VMWare Fusion](https://my.vmware.com/web/vmware/info/slug/desktop_end_user_computing/vmware_fusion/6_0)
  * You can use [VirtualBox](https://www.virtualbox.org) if you want to, to do that you will need to change the `config.vm.box` option of your `Vagrantfile`
* [Vagrant](http://vagrantup.com)

**I recommend you to download the tarball available in the dist folder, the file includes this repo with all git submodules, so your host machine won't need even `git`**

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone --recursive https://github.com/brennovich/brotodevbox.git
    host $ cd brotodevbox
    host $ vagrant up [--provider vmware_fusion]

That's it.

If the base box is not present that command fetches it first. The setup itself takes about 3 minutes in my MacBook Air. After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh
    Welcome to Ubuntu 13.10 LTS (GNU/Linux 3.11.0-12-generic x86_64)
    ...
    vagrant@brotodevbox:~$

Port 3000 in the host computer is forwarded to port 3000 in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:3000 in the host computer.

## What's In The Box

- Git
- Ruby 1.9.3 [Ubuntu package]
- rbenv
- ruby\_build
- PostgreSQL
- MySQL
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

    vagrant@brotodevbox:~$ ls ~/
    code

This workflow is convenient because in the host computer one normally has his editor of choice fine-tuned, Git configured, and SSH keys in place.

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
