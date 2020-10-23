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
  Boolean                 $package_manage = true,
  Boolean                 $service_manage = true,
  Boolean                 $service_active = true,
  Boolean                 $service_enable = true,
  String                  $user           = 'jackett',
  String                  $group          = 'jackett',
  String                  $install_path   = '/opt',
  Optional[Integer[1,10]] $keep           = 1,
  ) {

  contain jackett::config
  contain jackett::install
  contain jackett::service

  Class['::jackett::install']
  -> Class['::jackett::config']
  ~> Class['::jackett::service']

}
