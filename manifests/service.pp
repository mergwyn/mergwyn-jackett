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
      content => '[Unit]
  Description=Jackett Daemon
  After=network.target

  [Service]
  User=media
  Restart=always
  RestartSec=5
  Type=simple
  ExecStart=/usr/bin/mono --debug /opt/Jackett/JackettConsole.exe --NoRestart
  TimeoutStopSec=20

  [Install]
  WantedBy=multi-user.target
  '
      }

    service { 'jackett':
      ensure     => $jackett::service_ensure,
      name       => $jackett::service_name,
      provider   => $jackett::service_provider,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
# vim: tabstop=8 expandtab shiftwidth=2 softtabstop=2
