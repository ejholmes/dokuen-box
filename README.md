This is a set of Chef recipes for building and provisioning a dokuen paas
box.

## Testing with Vagrant

You can test the recipes against a fresh installation of Ubuntu 12.04.

First, build the basebox:

```bash
$ bundle exec veewee vbox build paas
$ bundle exec veewee vbox export paas
```

Then start the server with Vagrant:

```bash
$ vagrant up
```

Now provision the server using chef by running:

```bash
$ bundle exec librarian-chef install
$ rake vagrant:provision
```

## Provisioning

Add your public ssh key to the `~/.ssh/authorized_keys` file on the server for
the root user, then run:

```bash
$ bundle exec librarian-chef install
$ HOST="<hostname>" rake provision
```

## Software Stack

Here's a list of what is running on the server:

* Nginx
* Postgres
* Redis
* Dokuen
* Ruby 1.9.3/2.0.0

## Gotchas

* If you get errors with buildpacks, it may be caused by mason. Manually
  upgrading the mason gem may be a good idea:

  ```bash
  git clone git://github.com/ddollar/mason.git
  cd mason && gem build mason.gemspec && gem install *.gem
  ```

* Once provisioned, you need to manually clone the gitolite-admin repo and
  change `./config/gitolite.conf` to have the following:

  ```
  repo apps/[a-zA-Z0-9].*
      C = @all
      RW+ = CREATOR
      config hooks.pre = "/usr/local/var/bin/dokuen-deploy"
  ```
