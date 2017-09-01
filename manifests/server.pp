# == Class: elastizabbix::server
#
#  Installs elastizabbix template on Zabbix server.
#
# === Requirements
#
#  Requires 'zabbix' class (puppet/zabbix module).
#
# === Parameters
#
# [*install_template*]
#   Whether to install template or not. Actually since the class
#   doesn't do anything else besides installing template, setting
#   this parameter to false has the same effect as removing the
#   the class completely.
#   Default:   true
#
# [*zabbix_user*]
#   User Zabbix runs under.
#   Default:   zabbix
#
# === Example
#
#  class { 'elastizabbix::server': }
#
# === Authors
#
# Author Name: Fat Dragon www.itenlight.com
#
# === Copyright
#
# Copyright 2016 IT Enlight
#
class elastizabbix::server ($install_template = true,
  $zabbix_user = 'zabbix') {

  if $install_template {

    $templates_dir = $zabbix::params::zabbix_template_dir

    ensure_resource('file', 'templates_dir', {
        'ensure' => 'directory',
        'path'   => $templates_dir,
        'owner'  => $zabbix_user})

    exec { 'check Template App ElasticSearch.xml':
      command => '/bin/true',
      path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin', '/usr/local/sbin',
                  '/usr/local/bin'],
      onlyif  => "test ! -f ${templates_dir}/Template App ElasticSearch.xml",
      require => File['templates_dir'],
    }

    zabbix::template { 'Template App ElasticSearch':
      templ_name   => 'Template App ElasticSearch',
      templ_source => 'puppet:///modules/elastizabbix/templates_app_elasticsearch.xml',
      require      => Exec['check Template App ElasticSearch.xml'],
    }

  }

}