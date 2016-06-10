# == Class: elastizabbix
#
#  Installs elastizabbix agent at monitored node. 
#
# === Requirements
#
#  Requires 'zabbix-agent' class (puppet/zabbix module).
#
# === Parameters
#
# [*zabbix_user*]
#   User Zabbix agent runs under.
#   Default:   zabbix
#
# [*elasticsearch_url*]
#   Elasticsearch cluster URL. 
#   IMPORTANT: No trailing slash!
#   Default:   'http://localhost:9200'
#
# [*zabbix_script_dir*]
#   Zabbix agent external scripts dir. 
#   IMPORTANT: No trailing slash!
#   Default:   '/etc/zabbix/externalscripts'
#
# [*fd_patch*]
#   Whether to use patch described at 
#   https://github.com/mkhpalm/elastizabbix/issues/2
#   or not. If set to false, the original, unchanged
#   script will be installed. If true the script will
#   be slightly changed.
#   IMPORTANT: You should not rely on this parameter
#              in the future versions - very likely
#              it'll be removed.
#   Default:   true (recommended)
#
# === Example
#
#  class { 'elastizabbix': }
#
# === Authors
#
# Author Name: Fat Dragon www.itenlight.com
#
# === Copyright
#
# Copyright 2016 IT Enlight
#
class elastizabbix (
  $zabbix_user = 'zabbix',
  $elasticsearch_url = 'http://localhost:9200',
  $zabbix_script_dir = '/etc/zabbix/externalscripts',
  $fd_patch = true,
) {

  file { 'zabbix_script_dir':
    ensure => 'directory',
    path   => $zabbix_script_dir,
    owner  => $zabbix_user,
    mode   => '0755',
  }

  file { 'elastizabbix_script':
    ensure  => 'file',
    path    => "${zabbix_script_dir}/elastizabbix",
    owner   => $zabbix_user,
    mode    => '0754',
    content => template('elastizabbix/elastizabbix.erb'),
    require => File['zabbix_script_dir'],
  }

  # Zabbix conf:
  zabbix::userparameters { 'userparameter_pgsql':
    content => template('elastizabbix/elastizabbix.conf.erb'),
  }

}
