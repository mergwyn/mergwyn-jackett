require 'facter'

# Default for non-Linux nodes
#
Facter.add(:jackett_version) do
  setcode do
    nil
  end
end

# Linux
#
Facter.add(:jackett_version) do
  confine kernel: :linux
  setcode do
    if system("which jq > /dev/null 2>&1") && system("which curl > /dev/null 2>&1")
      # Facter::Util::Resolution.exec("curl -sI https://github.com/Jackett/Jackett/releases/latest | grep -Po 'tag\\/\\K(v\\S+)'")
      Facter::Util::Resolution.exec('curl -s https://api.github.com/repos/Jackett/Jackett/tags | jq --raw-output ".[0].name.[1:]"')
    end
  end
end
