vagabond
========

A while back, I needed a vagrant image.  I was in the middle of
doing lots of Docker container development, on a Mac, and wanted a
more comfortable, Linux-based environment.  It was easy enough to
start up a stock Ubuntu box and then apt-get my way to a working
system.  Then I was asked to give a few training sessions on
programming.  Since I personally dislike toy programming examples,
I opted to build on my Docker research to build a real project.

Big problem with teaching people who bring their own equipment is
the wild variance between each environment.  Different OS
versions, different installed packages, etc.  If you're going to
train, you need to avoid that variance, and a good way to avoid
that variance is Vagrant.

I have to admit, it was a perfect opportunity to learn how Vagrant
boxen are put together.

So, I started Vagabond.

**Vagabond** is a general-purpose Vagrant image, based on Ubuntu
Linux, that provides a delightful Linux programming experience for
the modern era.

It includes:

  - Docker (daemon and command line interface)
  - vim
  - tmux
  - tree
  - nmap
  - Golang 1.7.3 with `godep`, `golint` and Ginkog/Gomega.

It also includes sane default configuration for both `vim`, and
`tmux`.

Using Vagabond
--------------

Vagabond boxen are hosted on [Vagrant Atlas][cloud], specifically,
over [here][box].  To use it, however, you don't need to know any
of that.  Just use `vagrant init`:

    $ vagrant init jhunt/vagabond
    A `Vagrantfile` has been placed in this directory. You are now
    ready to `vagrant up` your first virtual environment! Please read
    the comments in the Vagrantfile as well as documentation on
    `vagrantup.com` for more information on using Vagrant.

Then start it up (`vagrant up`) and SSH in (`vagrant ssh`).

    $ vagrant up
    ...

    $ vagrant ssh
    ...

Developing Vagabond
-------------------

If you want to develop on Vagabond, all you need to do is modify
`scripts/bootstrap.sh` and then rebuild the box, via `make build`
and `make import`.

Further Reading
---------------

There really isn't any; but here are [some slides][slides].



[cloud]:  https://atlas.hashicorp.com/boxes/search
[box]:    https://atlas.hashicorp.com/jhunt/boxes/vagabond
[slides]: https://github.com/jhunt/slides/blob/master/vagrant/vagrant.pdf
