#version=RHEL8
#ignoredisk --only-use=sda
# Partition clearing information
# Firewall configuration
firewall --disabled
selinux --disabled
# Use text install
text
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8
# Use all local repositories
# Online repos
#repo --name=base --baseurl=http://mirror.centos.org/$contentdir/$releasever/BaseOS/$basearch/os/
#repo --name=appstream --baseurl=http://mirror.centos.org/$contentdir/$releasever/AppStream/$basearch/os/
#repo --name=extras --baseurl=http://mirror.centos.org/$contentdir/$releasever/AppStream/$basearch/os/
#repo --name=smith122rpm --baseurl=http://www.ipa.smith122.com/smith122/repo/rpm/
#repo --name=base --baseurl=https://www.ipa.smith122.com/mirror/centos/$releasever/BaseOS/$basearch/os/
#repo --name=appstream --baseurl=https://www.ipa.smith122.com/mirror/centos/$releasever/AppStream/$basearch/os/
#repo --name=extras --baseurl=https://www.ipa.smith122.com/mirror/centos/$releasever/extras/$basearch/os/
#repo --name=powertools --baseurl=https://www.ipa.smith122.com/mirror/centos/$releasever/PowerTools/$basearch/os/
#repo --name=epel --baseurl=https://www.ipa.smith122.com/mirror/fedora/epel/$releasever/Everything/$basearch

# Network information
#network  --bootproto=dhcp   --device=eth1 --onboot=on --activate
network  --bootproto=static --device=eth1 --onboot=on --activate --ip=10.10.20.11 --netmask=255.255.255.0 --gateway=10.10.20.1 --nameserver=8.8.8.8,8.8.4.4
network  --bootproto=dhcp   --device=eth2 --onboot=on --activate 
network  --hostname=cobbler-01
# Use network installation
#url --url="http://192.168.40.31/cblr/links/CentOS8-x86_64/"
url --url="http://http://mirror.centos.org/centos/8/BaseOS/x86_64/os"
liveimg --url="http://192.168.40.31/cblr/links/CentOS8-x86_64/images/install.img"
#url --url="http://www.ipa.smith122.com/mirror/centos/8/BaseOS/x86_64/os"
# Set crypted Root password - https://access.redhat.com/solutions/44662
rootpw --iscrypted $default_password_crypted
# Disable the Setup Agent on first boot
firstboot --disable
# Accept Eula
eula --agreed
# Reboot when the install is finished.
reboot
# Do not configure the X Window System
skipx
# System services
#services --enabled="chronyd"
# System timezone
timezone Asia/Ho_Chi_Minh --isUtc --nontp
bootloader --location=mbr --append="biosdevname=0 net.ifnames=0"
# Disk partitioning information
clearpart --all --initlabel
part swap            --asprimary     --fstype="swap"     --size=2048     --ondisk=vda
part /boot                           --fstype xfs        --size=512      --ondisk=vda
#part /                                                   --size=1        --ondisk=vda     --grow

part pv.01                                               --size=1        --ondisk=vda  --grow
part pv.02                                               --size=1        --ondisk=vdb  --grow
part pv.03                                               --size=1        --ondisk=vdc  --grow
volgroup vg00 pv.01 pv.02 pv.03
logvol / --vgname=vg00               --fstype=ext4       --size=2048     --name=lv_root        --grow
# or one volume used 100% of disk space 
# logvol / --fstype="xfs" --name=root --vgname=cl --percent=100 --grow
# if system used EFI
# part /boot/efi --fstype=efi --grow --maxsize=200 --size=20


%packages
@^minimal-environment
kexec-tools
network-scripts*

%end

%addon com_redhat_kdump --disable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end
