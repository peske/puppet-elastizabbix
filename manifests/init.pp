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
  $zabbix_script_dir = '/etc/zabbix/externalscripts'
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
