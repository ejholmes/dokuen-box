This is a set of Chef recipes for building and provisioning a dokuen paas
box.

## Testing with Vagrant
You can test the recipes against a fresh installation of Ubuntu 12.04.

First, build the basebox:

```bash
$ vagrant basebox build paas
$ vagrant basebox export paas
```

Then start the server with Vagrant:

```bash
$ vagrant up
```

Now provision the server using chef by running:

```bash
$ rake vagrant:provision
```

## Provisioning
Add your public ssh key to the `~/.ssh/authorized_keys` file on the server for
the root user, then run:

```bash
$ HOST="hostname-of-server" rake provision
```

## Software Stack
Here's a list of what is running on the server:

* Nginx (For reverse proxying to janky, geminabox, etc.)
* Dokuen