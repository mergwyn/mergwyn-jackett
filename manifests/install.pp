#
class jackett::install {

  #TODO tidy up old versions

  $package_name    = 'Jackett.Binaries.Mono'
  $package_version = $::jackett_version
  $install_path    = $::jackett::install_path
  $extract_dir     = "${install_path}/Jackett-${package_version}"
  $creates         = "${extract_dir}/Jackett"
  $link            = "${install_path}/Jackett"
  $repository_url  = 'https://github.com/Jackett/Jackett/releases/download/'
  $package_source  = "${repository_url}/${package_version}/${package_name}.tar.gz"
  $archive_name    = "${package_name}-${package_version}.tar.gz"
  $archive_path    = "${install_path}/${archive_name}"

  if $jackett::package_manage {
    file { $extract_dir: ensure => directory, }

    archive { $archive_name:
      path         => $archive_path,
      source       => $package_source,
      extract      => true,
      extract_path => $extract_dir,
      creates      => $creates,
      cleanup      => true,
      #TODO reference to mono
      #require      => Class['mono'],
      notify        => Service['jackett.service'],
    }
    file { $link:
      ensure    => 'link',
      target    => $creates,
      subscribe => Archive[$archive_name],
    }
  }
}
# vim: number tabstop=8 expandtab shiftwidth=2 softtabstop=2
