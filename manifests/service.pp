#
class jackett::service {

  if $jackett::service_manage == true {

    #TODO set user from variable
    #TODO move user setting to drop in
    systemd::unit_file { 'jackett.service':
      enable  => $jackett::service_enable,
      active  => $jackett::service_active,
      content => template('jackett/systemd.erb'),
    }
  }
}
# vim: number tabstop=8 expandtab shiftwidth=2 softtabstop=2
