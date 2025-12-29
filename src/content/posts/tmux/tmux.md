---
title: Cùng mình học Tmux - Công cụ quản lý terminal tuyệt vời
published: 2025-12-29
description: 'Terminal Multiplexer (Tmux) là một công cụ mạnh mẽ giúp quản lý nhiều phiên terminal trong một cửa sổ duy nhất.'
image: "https://images.unsplash.com/photo-1573164713988-8665fc963095?q=80&w=1169&auto=format&fit=crop"
tags: [Terminal, CLI tools, Server, Devops]
category: 'Công nghệ'
draft: false
lang: 'vi'
---

# Tại sao nên dùng Tmux?

- Repo: https://github.com/tmux/tmux

## 1. "Bất tử hóa" các Session (Persistence)
Đây là tính năng "ăn tiền" nhất của tmux đối với DevOps.

- **Vấn đề**: Khi bạn đang chạy một script quan trọng (ví dụ: database migration, backup, hay build app) mất hàng tiếng đồng hồ, rủi ro lớn nhất là **mất kết nối mạng** hoặc lỡ tay tắt cửa sổ terminal. Khi đó, process đang chạy sẽ bị kill ngay lập tức -> Hậu quả khôn lường.

- **Giải pháp tmux**: Tmux chạy tách biệt (detach) khỏi terminal hiện tại. Nếu rớt mạng hay tắt máy tính, **session tmux vẫn chạy ngầm trên server**.

- **Thực tế**: Bạn có thể SSH vào server, gõ lệnh chạy update, tắt máy đi ngủ. Sáng mai mở máy lên, SSH lại, dùng lệnh ```tmux attach``` và thấy mọi thứ vẫn đang chạy hoặc đã hoàn thành trọn vẹn.

## 2. Quản lý đa nhiệm trên một kết nối SSH duy nhất
Thay vì phải mở 5-6 cửa sổ iTerm hay PuTTY để kết nối vào cùng một server (mỗi cửa sổ làm một việc), tmux cho phép bạn làm tất cả trong một.

- Panes (Chia ô): Bạn có thể chia màn hình thành nhiều ô nhỏ (ngang/dọc).

  - Ví dụ DevOps: Ô bên trái sửa file config nginx (```vim```), ô bên phải xem log (```tail -f```), ô bên dưới restart service. Tất cả diễn ra cùng lúc trên một màn hình.

- **Windows (Tab)**: Tạo nhiều cửa sổ ảo khác nhau trong cùng một session.

  - Window 1: Backend logs.

  - Window 2: Database query.

  - Window 3: Htop monitoring.

## 3. Pair Programming & Debugging từ xa
Tmux cho phép nhiều người dùng cùng truy cập vào một session (Shared Session).

- **Kịch bản**: Server đang gặp lỗi nghiêm trọng. Bạn (ở Sài Gòn) và đồng nghiệp (ở Hà Nội) cùng SSH vào server và attach vào cùng một tmux session.

- **Lợi ích**: Cả hai sẽ nhìn thấy chung một màn hình, chung con trỏ chuột. Bạn gõ lệnh, đồng nghiệp nhìn thấy ngay lập tức. Đây là cách cực kỳ hiệu quả để hướng dẫn người mới hoặc debug tập thể (War room).

## 4. Lưu giữ Context (Ngữ cảnh làm việc)
DevOps thường phải quản lý nhiều dự án hoặc nhiều cụm server (cluster) khác nhau.

- Bạn có thể tạo các session đặt tên riêng biệt: ```tmux new -s production```, ```tmux new -s staging```.

- Khi cần chuyển ngữ cảnh, bạn chỉ cần detach khỏi ```staging``` và attach vào ```production```. Mọi thứ (thư mục đang đứng, lịch sử lệnh, các file đang mở) vẫn y nguyên như lúc bạn rời đi. Không cần phải ```cd``` hay ```zoxide``` lại từ đầu.

## 5. Khả năng tùy biến mạnh mẽ (Scriptable)
Tmux cực kỳ linh hoạt nhờ file cấu hình ```.tmux.conf.```

- Bạn có thể tạo các phím tắt (keybindings) riêng để thao tác nhanh hơn.

- Có thể tích hợp thanh trạng thái (status bar) hiển thị thông tin quan trọng: CPU load, RAM usage, IP address, hoặc thậm chí là tên bài hát đang nghe, ngay dưới đáy terminal.

- Hệ sinh thái plugin phong phú (như ```tmux-resurrect``` để lưu lại session ngay cả khi reboot server).

## 6. Đồng bộ hóa thao tác (Synchronize Panes)
Một tính năng ít người biết nhưng cực hay cho DevOps quản lý cụm server.

- Bạn có thể mở 4 pane, SSH vào 4 server khác nhau trong mỗi pane.

- Bật chế độ ```synchronize-panes```.

- Khi bạn gõ lệnh ```apt-get update``` ở một pane, **cả 3 pane còn lại cũng tự động gõ y hệt lệnh đó**. Giúp thao tác hàng loạt cực nhanh.

# Chiến thôi

## Bước 1: Cài đặt

- Cài đặt ```tmux``` trên server (https://github.com/tmux/tmux/wiki/Installing)

```bash
sudo apt install tmux        # Ubuntu/Debian
```

> Workflow chuẩn: Mở Kitty trên laptop -> SSH vào server -> Gõ ```tmux``` -> Làm việc trong đó.

## Bước 2: Khái niệm "Phím Prefix" (Quan trọng nhất)

Trong Kitty, bạn dùng phím tắt trực tiếp (VD: Ctrl+Shift+Enter). Nhưng trong Tmux, để tránh xung đột phím với các chương trình khác, bạn cần dùng một "chìa khóa" trước.

Mặc định, chìa khóa đó là: ```Ctrl``` + ```b``` (giữ Ctrl bấm b, rồi thả cả 2 ra).

- Mình sẽ gọi tắt là **[Prefix]**.

## Bước 3: Các lệnh sinh tồn cơ bản

- SSH vào server và thực hành ngay nhé!

**1. Tạo phiên làm việc (Session) mới:**

```zsh
tmux new -s my_work
# "my_work" là tên session, đặt sao cũng được
```
**2. Chia màn hình (Panes):**

- Chia đôi theo chiều dọc: Bấm **[Prefix]** rồi bấm % (Shift + 5).

- Chia đôi theo chiều ngang: Bấm **[Prefix]** rồi bấm " (Shift + ').

- Di chuyển giữa các ô: Bấm **[Prefix]** rồi bấm Phím mũi tên.

- Tắt một ô: Gõ lệnh exit hoặc bấm **[Prefix]** rồi x -> chọn y.

**3. Quản lý cửa sổ (Windows - giống Tab trong trình duyệt):**

- Tạo cửa sổ mới: Bấm **[Prefix]** rồi bấm ```c``` (create).

- Chuyển cửa sổ: Bấm **[Prefix]** rồi bấm số ```0```, ```1```, ```2```... hoặc ```n``` (next), ```p``` (previous).

**4. Thoát tạm (Detach) - Tính năng "bất tử": Đang làm việc dở, bạn muốn tắt máy đi về?**

- Bấm **[Prefix]** rồi bấm ```d``` (detach).

- Bạn sẽ thoát ra ngoài shell bình thường, nhưng session ```my_work``` vẫn chạy ngầm.

**5. Quay lại làm việc (Attach): Hôm sau bạn SSH vào lại server:**

- Xem danh sách các session đang chạy:

```zsh
tmux ls
```

- Chui vào lại session cũ:

```zsh
tmux attach -t my_work
```

**6. Cuộn trang (Scroll): Đây là cái người mới hay bực mình nhất vì lăn chuột không được.**

- Bấm **[Prefix]** rồi bấm ```[```.

- Giờ bạn có thể dùng phím mũi tên hoặc ```PageUp/PageDown``` để xem lại log cũ.

- Bấm ```q``` để thoát chế độ cuộn.

# Cấu hình cho dễ dùng hơn
Mặc định tmux không hỗ trợ chuột, hơi khó chịu cho người mới. Bạn hãy tạo một file cấu hình để bật chuột lên (có thể click chuyển ô, lăn chuột để cuộn).

  1. Tạo file config ở thư mục home: nano ~/.tmux.conf với nội dung:

```zsh
echo "set -g mouse on" >> ~/.tmux.conf
```

  2. Để áp dụng ngay lập tức mà không cần restart tmux, chạy lệnh (trong terminal):

```zsh
tmux source-file ~/.tmux.conf
```

# Phân tích một ví dụ config thực tế

- Nguồn: https://hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/

- .tmux.conf

```zsh
# change the prefix from 'C-b' to 'C-a'
# (remap capslock to CTRL for easy access)
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# start with window 1 (instead of 0)
set -g base-index 1

# start with pane 1
set -g pane-base-index 1

# split panes using | and -, make sure they open in the same path
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

unbind '"'
unbind %

# open new windows in the current path
bind c new-window -c "#{pane_current_path}"

# reload config file
bind r source-file ~/.tmux.conf

unbind p
bind p previous-window

# shorten command delay
set -sg escape-time 1

# don't rename windows automatically
set -g allow-rename off

# mouse control (clickable windows, panes, resizable panes)
set -g mouse on

# Use Alt-arrow keys without prefix key to switch panes
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# enable vi mode keys
set-window-option -g mode-keys vi

# set default terminal mode to 256 colors
set -g default-terminal "xterm-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# allow focus events to get through to applications running in tmux
set -g focus-events on


# Design Tweaks
# -------------

# loud or quiet?
set -g visual-activity on
set -g visual-bell on
set -g visual-silence off
setw -g monitor-activity off
set -g bell-action none

#  modes
setw -g clock-mode-colour yellow
setw -g mode-style 'fg=black bg=red bold'

# panes
set -g pane-border-style 'fg=red'
set -g pane-active-border-style 'fg=yellow'

# statusbar
set -g status-position bottom
set -g status-justify left
set -g status-style 'fg=red'

set -g status-left '#{?client_prefix,#[fg=green],#[fg=red]} '
set -g status-left-length 10


set -g status-right-style 'fg=black bg=yellow'
set -g status-right '#[bg=terminal fg=yellow]#[bg=yellow fg=black]%Y-%m-%d %H:%M#[bg=terminal fg=yellow]#[bg=yellow fg=black]'

setw -g window-status-current-style 'fg=black bg=red bold'
setw -g window-status-current-format '#[bg=terminal fg=red]#[bg=red fg=black]#I #W #F#[bg=terminal fg=red]#[bg=red fg=black]'

setw -g window-status-style 'fg=red'
setw -g window-status-separator ''
setw -g window-status-format ' #I #[fg=white]#W #[fg=yellow]#F '

setw -g window-status-bell-style 'fg=yellow bg=red bold'

# messages
set -g message-style 'fg=yellow bg=terminal bold'
```

- Đây là một file cấu hình này rất chất lượng. Đây là một cấu hình điển hình của một người dùng tmux lâu năm ("Power User"): họ tối ưu hóa từng phím bấm để thao tác nhanh nhất có thể và làm giao diện đẹp mắt, trực quan hơn

- Họ đã làm gì? Cùng phân tích nhé!

## 1. Thay đổi thói quen cơ bản (Key Mapping)
Đây là những dòng thay đổi cách bạn tương tác với bàn phím để đỡ mỏi tay hơn.

```zsh
# change the prefix from 'C-b' to 'C-a'
unbind C-b
set -g prefix C-a
bind C-a send-prefix
```
- **Giải thích**: Mặc định phím gọi lệnh là ```Ctrl + b```. Tác giả đổi thành ```Ctrl + a```.

- **Tại sao**: Phím a nằm ngay ngón út tay trái, dễ bấm hơn nhiều so với việc vươn tay ra bấm ```b```. (Lưu ý: Nếu bạn dùng ```Ctrl+a``` trong terminal để về đầu dòng lệnh, bạn sẽ cần bấm ```Ctrl+a``` hai lần để gửi lệnh đó đi).

```zsh
# start with window 1 (instead of 0)
set -g base-index 1
set -g pane-base-index 1
```
- **Giải thích**: Mặc định tmux đánh số cửa sổ từ 0. Tác giả đổi thành bắt đầu từ 1.

- **Tại sao**: Trên bàn phím, phím số ```1``` nằm sát bên trái, gần phím ```Ctrl+a```. Phím số ```0``` nằm tít bên phải. Khi muốn chuyển nhanh sang cửa sổ đầu tiên (```Prefix + 1```), tay bạn không cần di chuyển nhiều.

## 2. Tối ưu hóa thao tác chia màn hình (Splitting)
Đây là phần "đắt giá" nhất cho DevOps.

```zsh
# split panes using | and -
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
```
- **Giải thích**:

  - Thay vì dùng phím ```%``` và ```"``` (khó nhớ) để chia màn hình, tác giả dùng:

    - ```|``` (hình gạch đứng) để chia dọc.

    - ```-``` (hình gạch ngang) để chia ngang.

  - Quan trọng: ```-c "#{pane_current_path}"```

- **Tại sao**: Giả sử bạn đang đứng ở thư mục sâu thẳm ```/var/log/nginx/error/``` để debug. Khi bạn chia màn hình mới, **nó sẽ tự động mở ngay tại thư mục đó**, thay vì nhảy về thư mục ```home``` (```~```). Tiết kiệm thời gian ```cd``` lại.

## 3. Tăng tốc độ điều hướng (Navigation)
```zsh
# Use Alt-arrow keys without prefix key to switch panes
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
```
- **Giải thích**: bind -n nghĩa là không cần bấm Prefix. M là phím Meta (thường là phím Alt hoặc Option trên Mac).

- **Tác dụng**: Thay vì phải bấm ```Ctrl+a``` rồi thả ra rồi bấm mũi tên để chuyển ô. Bây giờ bạn chỉ cần giữ ```Alt``` + ```Phím mũi tên``` là bay nhảy qua lại giữa các ô. **Cực kỳ nhanh**

## 4. Tinh chỉnh hệ thống (System Tweaks)
```zsh
# shorten command delay
set -sg escape-time 1
```
- **Giải thích**: Giảm độ trễ khi bấm phím Esc.

- **Tại sao**: Nếu bạn dùng ```Vim``` hoặc ```NeoVim``` bên trong tmux, mặc định tmux sẽ đợi một chút sau khi bạn bấm ```Esc```. Điều này làm Vim cảm giác bị lag. Dòng này sửa lỗi đó.

```zsh
# reload config file
bind r source-file ~/.tmux.conf
```
- **- Tác dụng**: Khi bạn sửa file config xong, chỉ cần bấm ``Prefix + r`` là nó cập nhật ngay. Không cần tắt bật lại tmux.

## 5. Giao diện & Thẩm mỹ (The Eye Candy)
Phần lớn nửa dưới của file config (```# Design Tweaks```) là để làm đẹp thanh trạng thái (Status bar).

- **Màu sắc**: Tác giả chọn tông màu chủ đạo là **Đỏ** và **Vàng**.

- **Powerline Symbols**: Tác giả sử dụng các ký tự đặc biệt ,  để tạo hiệu ứng bo tròn (pill-shaped) cho các tab trên thanh status bar.

  - Lưu ý: Để hiển thị được các hình bán nguyệt này, máy tính của bạn (Kitty terminal) cần phải cài **Nerd Fonts** (ví dụ: *JetBrainsMono Nerd Font*). Nếu không cài, nó sẽ hiện ra các ô vuông lỗi font.

- Logic thông minh:

```zsh
set -g status-left '#{?client_prefix,#[fg=green],#[fg=red]} '
```
Dòng này rất hay: Bình thường cái cục bên trái màu **Đỏ**. Nhưng khi bạn bấm ```Ctrl+a``` (Prefix), nó sẽ chuyển sang màu **Xanh lá. -> Tác dụng**: Giúp bạn biết rõ mình đã bấm phím Prefix hay chưa, tránh việc gõ nhầm lệnh.

**Tổng kết: cần lưu ý khi sử dụng**:

1. **Phím Prefix**: Bạn phải làm quen lại với ```Ctrl+a``` thay vì ```Ctrl+b``` (hoặc sửa lại file config thành ```C-b``` nếu muốn giữ mặc định).

2. **Font chữ**: Hãy chắc chắn Kitty của bạn đang dùng một **Nerd Font** để hiển thị đẹp các ký tự.

3. **Phím Alt**: Trên MacOS, đôi khi phím ```Option``` (Alt) không hoạt động như phím ```Meta``` ngay lập tức. Bạn cần vào cấu hình Kitty (```macos_option_as_alt yes```) để cụm phím ```Alt + Mũi tên``` hoạt động.

**Việc cần làm ngay**: Copy nội dung này vào ```~/.tmux.conf``` của bạn, sau đó chạy lệnh:

```zsh
tmux source-file ~/.tmux.conf
```

Và tận hưởng sự chuyên nghiệp!
