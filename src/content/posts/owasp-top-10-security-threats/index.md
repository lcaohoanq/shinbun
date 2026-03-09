---
title: OWASP Top 10 - 10 Mối đe dọa Bảo mật Ứng dụng Web Phổ biến Nhất
published: 2026-01-02
description: 'Bài viết này giới thiệu về OWASP Top 10, một tài liệu quan trọng liệt kê 10 mối đe dọa bảo mật ứng dụng web phổ biến nhất, giúp các nhà phát triển và chuyên gia bảo mật hiểu rõ hơn về các rủi ro và cách phòng tránh chúng.'
image: "OWASP-Top-10-logo.png"
tags: [Security, OWASP]
category: 'An ninh mạng'
draft: true
lang: 'vi'
---

# Giới thiệu về OWASP Top 10

# A01. Broken Access Control

# A02. Cryptographic Failures

# A03. Injection

# A04. Insecure Design

# A05. Security Misconfiguration

# A06. Vulnerable and Outdated Components

# A07. Identification and Authentication Failures

# A08. Software and Data Integrity Failures

# A09. Security Logging and Monitoring Failures

# A10. Server-Side Request Forgery (SSRF)

---

# Tóm tắt

# OWASP Top 10 - Summary & Prevention Guide

## A01 - Broken Access Control (Phân quyền sai)

* **Vấn đề:** Người dùng có thể truy cập dữ liệu hoặc chức năng vượt quá quyền hạn của mình.
* **Ví dụ:** * URL: `GET /api/users/123`. Kẻ tấn công đổi `123` thành `124` để xem profile của người khác (lỗi IDOR).
  * User thường truy cập được các endpoint của admin như `/admin/delete-user`.
* **Cách phòng tránh:**
  * **Deny by Default:** Mặc định từ chối mọi quyền truy cập, trừ các tài nguyên công khai.
  * **Check quyền ở phía Server:** Luôn kiểm tra quyền sở hữu bản ghi trong mọi câu truy vấn (ví dụ: `WHERE id = ? AND user_id = current_user`).
  * **Sử dụng UUID:** Thay vì ID tăng dần (1, 2, 3), hãy dùng chuỗi ngẫu nhiên để hacker không thể đoán được ID tiếp theo.

---

## A02 - Cryptographic Failures (Lỗi mã hóa)

* **Vấn đề:** Dữ liệu nhạy cảm (mật khẩu, thẻ tín dụng) không được bảo vệ hoặc mã hóa bằng thuật toán yếu.
* **Ví dụ:** Lưu mật khẩu dưới dạng văn bản thuần (plain-text) hoặc dùng thuật toán cũ như MD5, SHA1 dễ bị bẻ khóa. Không sử dụng HTTPS khiến dữ liệu bị đánh cắp trên đường truyền.
* **Cách phòng tránh:**
  * **Hashing mật khẩu:** Sử dụng các thuật toán hiện đại có độ trễ như Argon2, bcrypt hoặc scrypt kèm theo Salt.
  * **Mã hóa dữ liệu lưu trữ:** Dùng AES-256 cho các thông tin nhạy cảm.
  * **Ép buộc HTTPS:** Cấu hình HSTS (HTTP Strict Transport Security) để ngăn chặn hạ cấp giao thức.

---

## A03 - Injection (Lỗi tiêm mã)

* **Vấn đề:** Dữ liệu từ người dùng không được kiểm soát bị đưa trực tiếp vào câu lệnh thực thi (SQL, Command, LDAP).
* **Ví dụ:** * Code: `query = "SELECT * FROM users WHERE user = '" + input + "'"`.
  * Nếu input là `' OR '1'='1`, hacker sẽ bypass được đăng nhập mà không cần mật khẩu.
* **Cách phòng tránh:**
  * **Parameterized Queries:** Luôn dùng câu lệnh có tham số (PreparedStatement).
  * **Input Validation:** Sử dụng "danh sách trắng" (allow-list) để lọc dữ liệu đầu vào.
  * **Escaping:** Mã hóa các ký tự đặc biệt trước khi đưa vào query.

---

## A04 - Insecure Design (Thiết kế không an toàn)

* **Vấn đề:** Lỗ hổng nằm ở tư duy thiết kế hệ thống, không phải ở việc viết code sai hay đúng.
* **Ví dụ:** Hệ thống reset password gửi link về email nhưng không có thời gian hết hạn, hoặc trang web thương mại điện tử không giới hạn số lượng sản phẩm mua dẫn đến lỗi "tràn số".
* **Cách phòng tránh:**
  * **Threat Modeling:** Phân tích các mối đe dọa ngay từ giai đoạn thiết kế kiến trúc.
  * **Security Patterns:** Sử dụng các mẫu thiết kế bảo mật đã được kiểm chứng.
  * **Rate Limiting:** Giới hạn số lần thử (retry) đối với các tính năng quan trọng như Login, Reset Password.

---

## A05 - Security Misconfiguration (Cấu hình sai)

* **Vấn đề:** Để quên cấu hình mặc định, mở các tính năng không cần thiết hoặc hiển thị thông tin lỗi quá chi tiết.
* **Ví dụ:** * Để debug mode = ON trên production khiến hacker thấy được cấu trúc code khi app lỗi.
  * Dùng mật khẩu mặc định (admin/admin).
  * Cấu hình CORS mở cho tất cả mọi người (`*`).
* **Cách phòng tránh:**
  * **Hardening:** Loại bỏ các tính năng, sample app, tài khoản mặc định không dùng tới.
  * **Automated Configuration:** Sử dụng các công cụ quản lý cấu hình (Terraform, Ansible) để đảm bảo môi trường đồng nhất và an toàn.

---

## A06 - Vulnerable and Outdated Components (Dùng thư viện cũ)

* **Vấn đề:** Sử dụng các thư viện, framework (npm, NuGet, Maven) có lỗ hổng đã được công bố (CVE).
* **Ví dụ:** Sử dụng Log4j phiên bản cũ dẫn đến lỗi Log4Shell cho phép hacker chiếm quyền điều khiển server từ xa.
* **Cách phòng tránh:**
  * **SCA (Software Composition Analysis):** Sử dụng công cụ quét lỗi thư viện tự động như `npm audit`, Snyk hoặc Dependabot trên GitHub.
  * **Chính sách cập nhật:** Chỉ tải thư viện từ nguồn chính thống và có kế hoạch nâng cấp định kỳ.

---

## A07 – Identification and Authentication Failures (Lỗi xác thực)

* **Vấn đề:** Xác nhận danh tính người dùng lỏng lẻo.
* **Ví dụ:** * Hệ thống cho phép hacker Brute-force mật khẩu mà không bị khóa.
  * Token JWT không có thời gian hết hạn (expire) hoặc session không thay đổi sau khi login (Session Fixation).
* **Cách phòng tránh:**
  * **MFA (Multi-Factor Authentication):** Bắt buộc hoặc khuyến khích dùng xác thực 2 lớp.
  * **Quản lý Session:** Hủy session sau khi logout hoặc sau một thời gian không hoạt động.
  * **Chặn Brute-force:** Khóa tài khoản tạm thời sau N lần nhập sai.

---

## A08 - Software and Data Integrity Failures (Lỗi toàn vẹn dữ liệu)

* **Vấn đề:** Tin tưởng vào các bản cập nhật phần mềm hoặc dữ liệu từ nguồn không xác thực.
* **Ví dụ:** * Ứng dụng tự động tải plugin từ một server không được ký số (Digital Signature).
  * Deserialize dữ liệu từ người dùng gửi lên mà không kiểm tra, dẫn đến thực thi mã độc.
* **Cách phòng tránh:**
  * **Digital Signatures:** Luôn kiểm tra chữ ký số của các file update/artifact.
  * **Verify Integrity:** Sử dụng Checksum (MD5/SHA256) để đảm bảo file không bị sửa đổi.
  * **Code Review:** Kiểm tra kỹ quy trình CI/CD để tránh mã độc bị chèn vào pipeline.

---

## A09 - Security Logging and Monitoring Failures (Lỗi ghi log/giám sát)

* **Vấn đề:** Không ghi lại các sự kiện bảo mật hoặc không có hệ thống cảnh báo khi bị tấn công.
* **Ví dụ:** Hacker thực hiện scan lỗ hổng suốt 1 tháng nhưng không hề có log ghi lại, hoặc có log nhưng admin không bao giờ đọc cho đến khi dữ liệu bị xóa sạch.
* **Cách phòng tránh:**
  * **Audit Log:** Ghi lại mọi sự kiện quan trọng (login thất bại, đổi mật khẩu, truy cập admin).
  * **Centralized Logging:** Đẩy log về hệ thống tập trung (ELK, Splunk) để khó bị hacker xóa.
  * **Monitoring & Alerting:** Thiết lập cảnh báo tự động khi số lượng lỗi 4xx/5xx tăng đột biến.

---

## A10 - Server-Side Request Forgery - SSRF (Lợi dụng Server gọi nội bộ)

* **Vấn đề:** Ứng dụng nhận một URL từ người dùng và thực hiện fetch dữ liệu từ URL đó mà không kiểm soát đích đến.
* **Ví dụ:** App có tính năng "Preview ảnh từ URL". Hacker nhập: `http://169.254.169.254/latest/meta-data/` để lấy thông tin nhạy cảm của server Cloud (AWS/Azure) hoặc truy cập vào database nội bộ qua `http://localhost:5432`.
* **Cách phòng tránh:**
  * **Allow-list:** Chỉ cho phép server gọi tới các domain/IP cụ thể đã được định nghĩa trước.
  * **Network Isolation:** Chặn server ứng dụng truy cập vào các dải IP nội bộ không cần thiết ở mức tường lửa.
  * **Input Sanitization:** Không chấp nhận các URL trỏ về `localhost` hoặc IP nội bộ.
