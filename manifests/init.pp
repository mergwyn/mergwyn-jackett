# Class: jackett
# ===========================
#
# Full description of class jackett here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * package_manage
# * service_manage
# * service_enable
# * user
# * group
#
# Examples
# --------
#
# @example
#    class { 'jackett':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class jackett (
  Boolean $package_manage = true,
  Boolean $service_manage = true,
  Boolean $service_enable = true,
  String  $user = 'jackett',
  String  $group = 'jackett',
  ) {

  contain jackett::config
  contain jackett::install
  contain jackett::service

  Class['::jackett::install']
  -> Class['::jackett::config']
  ~> Class['::jackett::service']

}
# vim: nu tabstop=8 expandtab shiftwidth=2 softtabstop=2