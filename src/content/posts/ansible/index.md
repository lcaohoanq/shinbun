---
title: Ansible 101
published: 2026-01-02
description: ''
image: "ansible.png"
tags: [Linux, Server, Bash, yml, Automation, DevOps]
category: 'Công nghệ'
draft: false
lang: 'vi'
---

# Mở đầu

- Các cách để tự động hóa việc quản lí server
  - Bash Scripting / Batch Scripting
  - Python/PERL/Ruby Scripting
  - Powershell
  - Puppet (written in Ruby)
  - Salt Stack (written in Python)
  - Chef
  - Ansible (written in Python): đơn giản, dễ học, không cần agent cài trên server quản lí, sử dụng các kết nối có sẵn của OS (Linux: SSH, Windows: WinRM)
  - Terraform (infrastructure as code): tập trung hơn cho cloud automation

# Ứng dụng

- Automation: Bất kì hệ thống nào
- Change Management:
- Provisioning
- Orchestration

# Cách hoạt động

- Ansible sử dụng mô hình client-server, trong đó máy chủ Ansible (control node) quản lý các máy khách (managed nodes) thông qua giao thức SSH (cho Linux), WinRM (cho Windows) và API (cho cloud).
- Viết yaml chạy trên control node, gọi là playbook, mô tả các tác vụ cần thực hiện trên managed nodes. Sẽ dịch từ yaml sang các lệnh shell tương ứng và gửi qua SSH/WinRM để thực thi trên managed nodes.
