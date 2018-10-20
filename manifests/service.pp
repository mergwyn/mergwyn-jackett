#
class jackett::service {


  if ! ($jackett::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $jackett::service_manage == true {

    #TODO set user from variable
    #TODO move user setting to drop in
    systemd::unit_file { 'jackett.service':
      enable  => $jackett::service_enable,
      active  => true,
      content => content => template('jackett/systemd.erb'),
  }
}
# vim: tabstop=8 expandtab shiftwidth=2 softtabstop=2
