#
class jackett::install {

  #TODO get /opt from variable
  $install_path   = $::jackett::install_path
  $package_name   = 'Jackett.Binaries.Mono'
  $package_version = $::jackett_version
  $repository_url = 'https://github.com/Jackett/Jackett/releases/download/'
  $package_source = "${repository_url}/${package_version}/${package_name}.tar.gz"
  $archive_name   = "${package_name}-${package_version}.tgz"

  if $jackett::package_manage {
    #TODO set user from variable
    archive { 'jackett_package_zip':
      path         => "${install_path}/${package_name}_${package_version}.tar.gz",
      source       => $package_source,
      user         => $::jacket::user,
      group        => $::jacket::group,
      extract      => true,
      extract_path => $install_path,
      creates      => "${install_path}/Jackett",
      cleanup      => false,
      #TODO reference to mono
      #require      => Class['mono'],
    }
  }
}
# vim: tabstop=8 expandtab shiftwidth=2 softtabstop=2
