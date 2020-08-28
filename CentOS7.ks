#platform=x86, AMD64, or Intel EM64T
#version=DEVEL
# Firewall configuration
firewall --disabled
# Install OS instead of upgrade
install
# Use HTTP installation media
url --url="http://10.10.20.240/cblr/links/CentOS7-x86_64/"

# Root password
rootpw --iscrypted $default_password_crypted

# Network information
network --bootproto=dhcp --device=eth0 --onboot=on

# Reboot after installation
reboot

# System authorization information
auth useshadow passalgo=sha512

# Use graphical install
graphical

firstboot disable

# System keyboard
keyboard us

# System language
lang en_US

# SELinux configuration
selinux disabled

# Installation logging level
logging level=info

# System timezone
timezone Asia/Ho_Chi_Minh

# System bootloader configuration
bootloader location=mbr

clearpart --all --initlabel
part swap --asprimary --fstype="swap" --size=2048
part /boot --fstype xfs --size=512
part / --size=1 --grow

%packages
@^minimal

@core
%end
%addon com_redhat_kdump --disable --reserve-mb='auto'
%end
