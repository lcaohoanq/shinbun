---
title: Git 101
published: 2025-02-01
description: "Học git cho đời dev bớt khổ"
tags: [Git, Version Control, Branch, Repository, Collaboration]
category: 'Công nghệ'
draft: false
lang: "en"
---

# Git 101: Các lệnh Git thiết yếu cho mọi developer

> Trên trường hầu như không dạy về Git, nhưng đây là kĩ năng tối quan trọng mà hầu như tất cả developer bắt buộc đều phải biết sử dụng. Trong bài viết này, mình sẽ chia sẻ những lệnh Git thiết yếu mà mọi developer nên nắm vững để quản lý code hiệu quả và cộng tác mượt mà trong các dự án phát triển phần mềm.

## Bắt đầu với Git

### Cấu hình ban đầu

Trước khi lao vào gõ lệnh, hãy đảm bảo Git đã được cấu hình ngon lành:

```bash
# Đặt thông tin cá nhân
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Đặt trình soạn thảo mặc định
git config --global core.editor "vim"
```

### Khởi tạo repository

Bắt đầu một Git repository mới hoặc clone một repository có sẵn:

```bash
# Khởi tạo repository mới
git init

# Clone một repository có sẵn
git clone https://github.com/username/repository.git
```

## Các lệnh Git dùng hằng ngày

### Kiểm tra trạng thái và lưu thay đổi

```bash
# Kiểm tra trạng thái repository
git status

# Thêm file vào khu vực staging
git add filename.txt        # Thêm một file cụ thể
git add .                  # Thêm tất cả các file
git add *.js              # Thêm tất cả file JavaScript

# Tạo commit
git commit -m "Your meaningful commit message"
git commit -am "Add and commit in one command" # Chỉ hoạt động với file đã được theo dõi
```

### Làm việc với branch và di chuyển giữa các nhánh

```bash
# Liệt kê các branch
git branch                 # Branch local
git branch -r             # Branch remote
git branch -a             # Tất cả branch

# Tạo và chuyển sang branch mới
git checkout -b feature/new-feature
git switch -c feature/new-feature

# Chuyển giữa các branch
git checkout main
git switch main

# Xoá branch
git branch -d branch-name  # Xoá an toàn
git branch -D branch-name  # Xoá cưỡng bức
```

## Làm việc với remote repository

### Các thao tác với remote

```bash
# Liệt kê các remote
git remote -v

# Thêm remote
git remote add origin https://github.com/username/repo.git

# Lấy cập nhật mới nhất từ remote
git fetch origin

# Kéo thay đổi từ remote về
git pull origin main

# Đẩy thay đổi lên remote
git push origin feature/new-feature
```

## Xem lại thay đổi

### Xem lịch sử và so sánh khác biệt

```bash
# Xem lịch sử commit
git log
git log --oneline         # Dạng rút gọn
git log --graph           # Hiển thị dạng đồ thị

# Xem thay đổi
git diff                  # So sánh thư mục làm việc với staging
git diff --staged        # So sánh staging với commit gần nhất
git diff branch1..branch2 # So sánh giữa hai branch
```

## Các thao tác nâng cao

### Tạm cất thay đổi (stash)

```bash
# Tạm cất thay đổi để làm việc khác
git stash

# Xem danh sách stash
git stash list

# Áp dụng stash gần nhất
git stash apply

# Áp dụng một stash cụ thể
git stash apply stash@{2}

# Xoá một stash
git stash drop stash@{0}
```

### Merge và rebase

```bash
# Merge một branch
git merge feature/new-feature

# Rebase branch hiện tại
git rebase main

# Interactive rebase
git rebase -i HEAD~3      # Rebase 3 commit gần nhất
```

## Khôi phục và hoàn tác thay đổi

### Sửa lỗi và quay ngược

```bash
# Hoàn tác commit gần nhất (nhưng giữ lại thay đổi trong code)
git reset HEAD~1

# Reset cứng về một commit cụ thể
git reset --hard commit-hash

# Tạo commit đảo ngược (revert) một commit
git revert commit-hash
```

## Best practices (Thói quen nên có)

### 1. Commit message

Viết commit message rõ ràng, dễ hiểu và có ý nghĩa:

```bash
# Ví dụ commit message “xịn xò”
git commit -m "feat: add user authentication system

- Implement JWT token generation
- Add password hashing
- Create user validation middleware"
```

- Sử dụng prefix như `feat:`, `fix:`, `docs:`, `refactor:` để phân loại commit, tham khảo theo [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

### 2. Quy ước đặt tên branch

Dùng tên branch mô tả rõ ràng kèm tiền tố:

- `feature/` cho tính năng mới
- `bugfix/` cho sửa lỗi
- `hotfix/` cho sửa lỗi gấp trên production
- `release/` cho chuẩn bị phát hành

Ví dụ:

```bash
git checkout -b feature/user-authentication
```

### 3. Cập nhật thường xuyên

Giữ cho repository local luôn cập nhật với branch chính:

```bash
git checkout main
git pull origin main
git checkout your-branch
git rebase main
```

## Mẹo workflow với Git

### Tạo một tính năng mới

```bash
# Bắt đầu một feature mới
git checkout main
git pull origin main
git checkout -b feature/new-feature

# Làm việc trên feature
git add .
git commit -m "feat: implement new feature"

# Cập nhật với branch main
git checkout main
git pull origin main
git checkout feature/new-feature
git rebase main

# Đẩy lên remote
git push origin feature/new-feature
```

### Quy trình code review

```bash
# Cập nhật feature branch trước khi tạo PR / review
git checkout feature/new-feature
git fetch origin
git rebase origin/main

# Sửa theo comment review
git add .
git commit -m "fix: address review comments"
git push origin feature/new-feature
```

## Xử lý sự cố thường gặp

### Giải quyết xung đột merge

```bash
# Khi xảy ra conflict
git status                  # Xem file đang bị conflict
# Mở file, sửa conflict cho đúng
git add resolved-file.txt
git commit -m "resolve merge conflicts"
```

### Khôi phục thay đổi đã “mất”

```bash
# Xem reflog
git reflog

# Khôi phục commit đã mất
git checkout -b recovery-branch lost-commit-hash
```

## Kết luận

Những lệnh Git trên là “bộ công cụ cơ bản” để bạn sinh tồn trong thế giới version control hiện đại. Dù Git còn rất nhiều lệnh và tính năng nâng cao, chỉ cần nắm vững những lệnh thiết yếu này là bạn đã xử lý được hầu hết các tình huống hằng ngày rồi.

Hãy luôn nhớ:

- Viết commit message rõ ràng, có ý nghĩa
- Giữ branch của bạn luôn cập nhật với branch chính
- Đặt tên branch sao cho nhìn vào là hiểu đang làm gì
- Thường xuyên push code lên remote để tránh “mất trắng”
- Luôn xem lại thay đổi (`git diff`, `git status`) trước khi commit

Càng dùng Git nhiều, bạn sẽ càng thấy nó quen tay và “dễ như ăn kẹo”. Đừng ngại tạo một repository thử nghiệm để thoải mái vọc, reset, rebase, phá rồi sửa – đó là cách nhanh nhất để hiểu sâu Git.
