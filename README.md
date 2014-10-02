# novac

This is installs and configures Cybera's [novac](https://github.com/cybera/novac) utility.

## Configuration

Make sure you have something like the following in Hiera:

```yaml
novac::sudo_users:
  - 'www-data'
novac::config:
  openstack:
    release: 'icehouse'
  rabbitmq:honolulu:nova:
    host: 'nova-hl.example.com'
    username: 'nova'
    password: 'password'
  mysql:honolulu:nova:
    host: 'nova-hl.example.com'
    database: 'nova'
    user: 'query'
    password: "%{hiera('mysql::helper_password')}"
    master: true
  mysql:honolulu:cinder:
    host: 'nova-hl.example.com'
    database: 'cinder'
    user: 'query'
    password: "%{hiera('mysql::helper_password')}"
    master: true
  mysql:honolulu:glance:
    host: 'nova-hl.example.com'
    database: 'glance'
    user: 'query'
    password: "%{hiera('mysql::helper_password')}"
    master: true
  mysql:honolulu:keystone:
    host: 'nova-hl.example.com'
    database: 'keystone'
    user: 'query'
    password: "%{hiera('mysql::helper_password')}"
    master: true
```

Then apply the `novac::entry` manifest on a server that has roles like MySQL or RabbitMQ. Those servers will export the hiera config and fill in any needed values.

On servers where you want to use the `novac` command, apply the `novac` manifest. It will collect the exported config and build a `/etc/novac/config.ini` file.

## Notes

The `novac` utility is extremely site-specific to Cybera's clouds. While you might be able to get a few commands working out of the box, you definitely won't be able to use all commands.

