# 🍥Shinbun (lcaohoanq)

Một mẫu blog tĩnh được xây dựng với [Astro](https://astro.build).

[**🖥️ Bản Demo Trực Tuyến (Vercel)**](https://shinbun.vercel.app)&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;
[**🇻🇳 Tiếng Việt**](https://github.com/lcaohoanq/shinbun/blob/main/README.vi-VN.md)&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;
[**🇯🇵 日本語**](https://github.com/lcaohoanq/shinbun/blob/main/README.ja-JP.md)&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;

> Phiên bản README: `2024-09-10`

![image](https://github.com/user-attachments/assets/0cc757d6-a387-4b3b-ad2a-daf47084d79a)

## ✨ Tính năng

- [x] Xây dựng với [Astro](https://astro.build) và [Tailwind CSS](https://tailwindcss.com)
- [x] Hiệu ứng chuyển cảnh mượt mà
- [x] Chế độ sáng / tối
- [x] Tùy chỉnh màu sắc và banner
- [x] Thiết kế đáp ứng
- [ ] Bình luận
- [x] Tìm kiếm
- [ ] Mục lục

## 🚀 Cách sử dụng

1. [Tạo một repository mới](https://github.com/lcaohoanq/shinbun/generate) từ mẫu này hoặc fork repository này.
2. Để chỉnh sửa blog của bạn cục bộ, clone repository, chạy `pnpm install` VÀ `pnpm add sharp` để cài đặt các gói phụ thuộc.
   - Cài đặt [pnpm](https://pnpm.io) `npm install -g pnpm` nếu bạn chưa cài đặt.
3. Chỉnh sửa file cấu hình `src/config.ts` để tùy chỉnh blog của bạn.
4. Chạy `pnpm new-post <tên file>` để tạo một bài viết mới và chỉnh sửa nó trong `src/content/posts/`.
5. Triển khai blog của bạn lên Vercel, Netlify, GitHub Pages, v.v. theo [hướng dẫn](https://docs.astro.build/en/guides/deploy/). Bạn cần chỉnh sửa cấu hình trang web trong `astro.config.mjs` trước khi triển khai.

## ⚙️ Frontmatter của bài viết

```yaml
---
title: Bài viết blog đầu tiên của tôi
published: 2023-09-09
description: Đây là bài viết đầu tiên của blog mới với Astro.
image: ./cover.jpg
tags: [Foo, Bar]
category: Front-end
draft: false
lang: vi # Chỉ thiết lập nếu ngôn ngữ bài viết khác với ngôn ngữ trang web trong `config.ts`
---
```

## 🧞 Các lệnh

Tất cả các lệnh được chạy từ thư mục gốc của dự án, từ terminal:

| Lệnh                             | Hành động                                           |
| :---------------------------------- | :----------------------------------------------- |
| `pnpm install` AND `pnpm add sharp` | Cài đặt các gói phụ thuộc                            |
| `pnpm dev`                          | Khởi chạy máy chủ phát triển cục bộ tại `localhost:4321`      |
| `pnpm build`                        | Xây dựng trang web sản xuất của bạn tới `./dist/`          |
| `pnpm preview`                      | Xem trước trang web của bạn cục bộ, trước khi triển khai     |
| `pnpm new-post <tên file>`          | Tạo một bài viết mới                                |
| `pnpm astro ...`                    | Chạy các lệnh CLI như `astro add`, `astro check` |
| `pnpm astro --help`                 | Nhận trợ giúp sử dụng Astro CLI                     |

