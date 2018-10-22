#
class jackett::install {

  $install_path   = $::jackett::install_path
  $package_name   = 'Jackett.Binaries.Mono'
  $package_version = $::jackett_version
  $repository_url = 'https://github.com/Jackett/Jackett/releases/download/'
  $package_source = "${repository_url}/${package_version}/${package_name}.tar.gz"
  $archive_name   = "${install_path}/${package_name}-${package_version}.tar.gz"

  if $jackett::package_manage {
    archive { 'jackett_package_tar':
      path         => $archive_name,
      source       => $package_source,
      user         => $::jackett::user,
      group        => $::jackett::group,
      extract      => true,
      extract_path => $archive_name,
      creates      => $archive_name,
      cleanup      => false,
      #TODO reference to mono
      #require      => Class['mono'],
    }
  }
}
# vim: number tabstop=8 expandtab shiftwidth=2 softtabstop=2
