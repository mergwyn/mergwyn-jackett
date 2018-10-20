#
class jackett::install {

  #TODO get /opt from variable
  $install_path   = '/opt'
  $package_name   = 'Jackett.Binaries.Mono'
  $package_version = $::jackett_version
  $repository_url = 'https://github.com/Jackett/Jackett/releases/download/'
  $package_source = "${repository_url}/${package_version}/${package_name}.tar.gz"
  $archive_name   = "${package_name}-${package_version}.tgz"

  if $jackett::package_manage {
    #TODO set user from variable
    archive { 'jackett_package_zip':
      path         => "/opt/${package_name}_${package_version}.tar.gz",
      source       => $package_source,
      user         => 'media',
      group        => '513',
      extract      => true,
      extract_path => $install_path,
      creates      => $package_source,
      cleanup      => false,
      require      => Package['mono-complete'],
    }
  }
}
# vim: tabstop=8 expandtab shiftwidth=2 softtabstop=2
