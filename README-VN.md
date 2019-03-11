## <img src="./Images/img-icon.png" height ="30"> Charles Guide

*Written by __Nguyen Minh Tam__*

Reading English version right [here][Charles Guide EN Version].

Nếu bạn là một mobile developer, mình khá chắc là bạn đã từng gặp qua tình huống éo le `vỡ UI` ít nhất một lần trong đời. `Vỡ UI` thường được bắt gặp khi mà bạn có một cái text, nội dung của cái text này được lấy bằng cách truy xuất database, hoặc từ kết quả mà API trả về. Cơ mà bạn lại quên mất việc kiểm tra UI khi nội dung cái text này dài ra trên các màn hình khác nhau, dẫn tới hậu quả UI của bạn banh chè.

![UI Example][UI Example]

Mục đích của bài viết này giúp các bạn làm quen với một tool rất chy là bá đạo, cân từ debugging đến testing. 

Ví dụ nhé, nó giúp bạn có thể test các hiển thị lên UI của nhiều data set khác nhau như thế nào, ngay cả khi bạn chưa implement API. Trong một diễn biến khác, nó có thể giúp bạn debugging cách bạn call API đã đúng chưa: kiểm tra bạn đang gọi GET/POST/..., header ra sao, parameter như nào,... Ngoài ra nó còn cho phép bạn test những trường hợp download mạng chậm nữa.

Và cái tool thần thánh được nhắc đến trong bài viết này chính là `Charles - Web Debugging Proxy Application`.

> __Nhắn gửi:__ Các ví dụ mình đề cập trong bài viết này là những kinh nghiệm mình có được khi trong implement app trên iOS. Mình nghĩ về cơ bản thì develop Android và iOS khá giống nhau, nên chắc tài liệu này cũng có chút hữu ích với với các bạn Android developer.

### Mục lục

[Install Charles](#install-charles)

[Configure Charles](#configure-charles)

- [Configuring Browser and System](#configuring-browser-and-system)
  - [Đối với macOS Proxy](#đối-với-macos-proxy)
  - [Đối với iOS Device Setting](#đối-với-ios-device-setting)
  - [Đối với iOS Simulator](#đối-với-ios-simulator)

[Work with Charles Proxy](#work-with-charles-proxy)
- [Application Interface](#application-interface)

- [Debug with Charles](#debug-with-charles)
  - [Focus](#focus)
  - [Recording settings](#recording-settings)
  - [Throttle settings](#throttle-settings)
  - [Breakpoint](#breakpoint)
  - [Handle breakpoint](#handle-breakpoint)

- [Configuring SSL Proxying Certificates](#configuring-ssl-proxying-certificates)
  - [Đối với macOS](#đối-với-macos)
  - [Đối với iOS Device](#đối-với-ios-device)
  - [Đối với iOS Simulator](#đối-với-ios-simulator)

- [Enable SSL Proxying Setting](#enable-ssl-proxying-setting)

### Install Charles

Để cài đặt Charles cần:

- Truy cập vào đường link [https://www.charlesproxy.com][Download] và download file installer về máy

<center>
	<img src="./Images/img-install1.png" height="300"/>
</center>

- Khởi động installer đã down về, hoàn thành theo chỉ dẫn:

<center>
	<img src="./Images/img-install2.png" height="200"/>
	<img src="./Images/img-install3.png" height="200"/>
</center>

- Khởi động Charles:

<center>
	<img src="./Images/img-install4.png" height="300"/>
</center>

- Gói Charles free cho 30 ngày, vào đây để mua license nhé. Sau đó thì đi tới __Help > Register Charles... > Điền Register Name và License Key__ để đăng ký rồi restart lại Charles.

<center>
	<img src="./Images/img-register1.png" height="200"/>
	<br>
	<img src="./Images/img-register2.png" height="100"/>
	<img src="./Images/img-register3.png" height="100"/>
</center>

## Configure Charles

Phần set up Charles và môi trường là phần vô cùng quan trọng. Nếu bạn set up môi trường không đúng hoặc không đầy đủ, điều tất yếu là bạn sẽ chả thể làm việc được với nó.

Để giúp bạn có thể kiểm tra liệu mình đã set up đúng chưa, thì sau đây là checklist các bước mình sử dụng:

- [x] Config Proxy
- [x] Config Configuring SSL Proxying Certificates
- [x] Config focus host



### Reference

Đọc bản tiếng anh tại [đây][Charles Guide EN Version].

---

[Charles Guide EN Version]: ./README.md "Charles Guide EN Version"

[Download]: https://www.charlesproxy.com/download/