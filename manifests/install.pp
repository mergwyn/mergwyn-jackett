#
class jackett::install {

  if ! defined( Package[curl] ) { package { 'curl': ensure=>installed; } }
  if ! defined( Package[jq] )   { package { 'jq':   ensure=>installed; } }

# Only execute if jacket version has already been defined (first run may need the
# packages above to be installed

  if $::jackett_version {
    # Make sure version has is a string with at least 1 char
    unless $::jackett_version =~ String[1] {
      fail ("jackett_version cannot be an empty string '${::jackett_version}'")
    }
    case $facts['os']['architecture'] {
      'amd64': {
        $package_name = 'Jackett.Binaries.LinuxAMDx64'
      }
      default: {
        $package_name = 'Jackett.Binaries.Mono'
      }
    }

    $package_version = $::jackett_version
    $install_path    = $::jackett::install_path
    $extract_dir     = "${install_path}/Jackett-${package_version}"
    $creates         = "${extract_dir}/Jackett"
    $link            = "${install_path}/Jackett"
    $repository_url  = 'https://github.com/Jackett/Jackett/releases/download/'
    $package_source  = "${repository_url}/v${package_version}/${package_name}.tar.gz"
    $archive_name    = "${package_name}-${package_version}.tar.gz"
    $archive_path    = "${install_path}/${archive_name}"

    if $jackett::package_manage {

      file { $extract_dir:
        ensure => directory,
        owner  => $::jackett::user,
        group  => $::jackett::group,
      }

      archive { $archive_name:
        path         => $archive_path,
        source       => $package_source,
        extract      => true,
        extract_path => $extract_dir,
        creates      => $creates,
        cleanup      => true,
        user         => $::jackett::user,
        group        => $::jackett::group,
        #TODO reference to mono
        #require      => Class['mono'],
        notify       => Service['jackett.service'],
      }
      file { $link:
        ensure    => 'link',
        target    => $creates,
        subscribe => Archive[$archive_name],
      }
      exec {'jackett_tidy':
        cwd         => $install_path,
        path        => '/usr/sbin:/usr/bin:/sbin:/bin:',
        command     => "ls -dtr ${link}-* | head -n -${jackett::keep} | xargs rm -rf",
        #onlyif      => "test $(ls -d ${link}-* | wc -l) -gt ${jackett::keep}",
        refreshonly => true,
        subscribe   => Archive[$archive_name],
      }
    }
  }
}
