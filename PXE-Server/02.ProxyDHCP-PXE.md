# ProxyDHCP
## 1. Cách ProxyDHCP làm việc
1. Khi PXE client khởi động, nó gửi bản tin broadcast DHCP Discover trên toàn mạng, bao gồm thông tin mà Client muốn từ DHCP-Server và một số thông tin xác định nó là thiết bị có khả năng PXE.
2. DHCP-server gửi 1 DHCP-Offer cho Client gồm IP address, subnet mask, router (gateway) address, dns domain name...
3. Client tự xác nhận nó là 1 PXE-Client và proxyDHCP-Server cũng trả về 1 DHCP-Offer nhưng không chứa thông tin về IP address mà cung cấp next-server-name vaf boot file name được sử dụng trong phiên TFTP.
4. PXE-Client phản hồi DHCP-Offer với 1 DHCP-Request chứa yêu cầu IP từ DHCP-server.
5. DHCP-Server phàn hổi 1 ACK (acknowledgement), cho Client biết có thể sử dụng IP mà nó yêu cầu.
6. Cient giờ có IP, TFTP-Server name, boot file name và nó khởi tạo 1 phiên TFTP để download file boot.
## Tài liệu tham khảo
- https://wiki.fogproject.org/wiki/index.php?title=ProxyDHCP_with_dnsmasq
