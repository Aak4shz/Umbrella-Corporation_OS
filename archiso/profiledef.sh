#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="umbrella-os"
iso_label="UMBRELLA_OS_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="Umbrella Corporation OS Project <https://github.com/Aak4shz/Umbrella-Corporation_OS>"
iso_application="Umbrella OS — Developer & AI Workstation"
iso_version="1.0.0"
install_dir="arch"
buildmodes=('iso')
bootmodes=(
    'bios.syslinux'
    'uefi.grub'
)
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/local/bin/umbrella-post-install.sh"]="0:0:755"
)
