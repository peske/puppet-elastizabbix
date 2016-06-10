# elastizabbix #

The module installs and configures [elastizabbix monitoring agent and template](https://github.com/mkhpalm/elastizabbix) used for monitoring ElasticSearch cluster in Zabbix.

The template is pretty simple, yet some additional info can be found at [Puppet, Zabbix and ElasticSearch - elastizabbix Module](https://www.itenlight.com/blog/2016/06/09/Puppet%2C+Zabbix+and+ElasticSearch+-+elastizabbix+Module).

## Server Side

The only thing the module does at the server side (at Zabbix server), is installing "Template App ElasticSearch" Zabbix template.

### Server Side Requirements

The module requires 'zabbix' class at the server side. See [puppet/zabbix module](https://forge.puppet.com/puppet/zabbix) at puppet forge.

### elastizabbix Server Side Example

```
class { 'elastizabbix::server': }
```

**Note:** The class will automatically install the template only if you're using [puppet/zabbix module](https://forge.puppet.com/puppet/zabbix) with `manage_resources` set to `true`. For details check [Puppet, Zabbix and ElasticSearch - elastizabbix Module](https://www.itenlight.com/blog/2016/06/09/Puppet%2C+Zabbix+and+ElasticSearch+-+elastizabbix+Module).

## Client Side

At the client side (monitored ElasticSearch node) the module installs elastizabbix script and configuration file.

**NOTE:** elastizabbix client should be installed on **only one** node from ElastacSearch cluster, not on all of them.

### Client Side Requirements

The module requires 'zabbix-agent' class at the client side ([puppet/zabbix module](https://forge.puppet.com/puppet/zabbix)).

### elastizabbix Client Side Example

```
class { 'elastizabbix': }
```

## Parameters

Often you'll use both mentioned classes without specifying any parameter (the default values should work). Nevertheless you should check [mentioned page](https://www.itenlight.com/blog/2016/06/09/Puppet%2C+Zabbix+and+ElasticSearch+-+elastizabbix+Module) for list of available parameters with descriptions. 

## License

This module is published under Apache 2.0 license, but the original [elastizabbix project](https://github.com/mkhpalm/elastizabbix) is published under MIT License. Anyway you are pretty much free to use both in a way you want.

## Release History

### v0.1.1

**Date:** Jun 10. 2016

**Release Info:**
* `fd_patch` parameter is removed since the original project is changed to include the patch. Nothing important has been changed, so **no upgrade is needed**.

### v0.1.0

**Date:** Jun 9. 2016

**Release Info:**
* Initial release.