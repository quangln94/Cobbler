# Cài đặt Cobbler trên CentOS7

## 1. Cài đặt
- Cài đặt package
```sh
yum install cobbler cobbler-web dnsmasq syslinux xinetd bind bind-utils dhcp debmirror pykickstart fence-agents-all -y
```
Trong đó:
+ `cobbler`, `cobbler-web`: Các package cài đặt chạy service cobbler và giao diện web của cobbler.
+ `dnsmasq`, `bind`, `bind-utils`, `dhcp`: Các package chạy dịch vụ quản lý DNS và quản lý DHCP cho các máy client boot OS từ cobbler.
+ `syslinux`: Chương trình bootloader và tiện ích cho phép đẩy vào client cho phép client boot OS qua mạng.
+ `xinetd`: Tạo socket kết nối với máy client. Được sử dụng để quản lý và tạo socket cho TFTP server truyền file boot cho client.
+ `debmirror`: Package cài đặt cho phép tạo một mirror server chứa các gói phần mềm cài đặt của các distro trên một server local.
+ `pykickstart`: thư viện python cho phép đọc và chỉnh sửa nội dung file kickstart, hỗ trợ cobbler chỉnh sửa file kickstart thông qua giao diện web.

- Khởi động services
```sh
systemctl start cobblerd
systemctl enable cobblerd
systemctl start httpd
systemctl enable httpd
```
## 2. Cấu hình
