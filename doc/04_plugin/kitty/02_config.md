# config kitty

## font

```bash
mkdir -p ~/.config/kitty
nvim ~/.config/kitty/kitty.conf
```

Write in,

```txt
font_family JetBrainsMono Nerd Font
font_size 13.0
map alt+1 goto_tab 1
map alt+2 goto_tab 2
map alt+3 goto_tab 3
map alt+4 goto_tab 4
map alt+5 goto_tab 5
map alt+6 goto_tab 6
map alt+7 goto_tab 7
map alt+8 goto_tab 8
map alt+9 goto_tab 9
map alt+0 goto_tab -1
```

## shortcuts

系统设置 → Keyboard / 键盘 → Shortcuts / 快捷键
找到“打开终端”之类的项，把命令改成：
`(/home/mintusr/.local/bin/kitty-ibus)`, which according to the config of ibus.

```{txt}
新窗口：Ctrl+Shift+Enter
想开新的页签：Ctrl+Shift+T
想切页签：Ctrl+Shift+Left / Ctrl+Shift+Right
想关页签：Ctrl+Shift+Q
```

## The config of IBus

### Install and enable IBus

Install IBus and the Chinese pinyin engine first:

```bash
sudo apt update
sudo apt install ibus ibus-libpinyin
```

Set IBus as the input method framework:

```bash
im-config -n ibus
```

Open IBus preferences:

```bash
ibus-setup
```

In **Input Method**, add:

```text
Chinese - Intelligent Pinyin
```

Then reboot.

After reboot, check the current IBus engine:

```bash
ibus engine
```

If it is not `libpinyin`, switch it manually:

```bash
ibus engine libpinyin
```

### Optional: uninstall fcitx

If IBus works correctly, remove old fcitx packages to avoid conflicts:

```bash
sudo apt remove fcitx fcitx-bin fcitx-data fcitx-module-dbus fcitx-module-x11
```

Then reboot.

### Configure kitty for IBus

Kitty on X11 needs the IBus environment variables to enable Chinese input. Since kitty is installed under `~/.local/kitty.app`, create a small wrapper script first:

```bash
mkdir -p ~/.local/bin ~/.local/share/applications

cat > ~/.local/bin/kitty-ibus <<'EOF'
#!/bin/sh
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export GLFW_IM_MODULE=ibus
exec "$HOME/.local/kitty.app/bin/kitty" "$@"
EOF

chmod +x ~/.local/bin/kitty-ibus
```

Copy kitty's desktop file from the local kitty installation:

```bash
cp ~/.local/kitty.app/share/applications/kitty.desktop \
  ~/.local/share/applications/kitty.desktop
```

Open this desktop file:

```bash
nvim ~/.local/share/applications/kitty.desktop
```

Then write in:

```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=kitty
GenericName=Terminal emulator
Comment=Fast, feature-rich, GPU based terminal
TryExec=/home/mintusr/.local/bin/kitty-ibus
StartupNotify=true
Exec=/home/mintusr/.local/bin/kitty-ibus
Icon=/home/mintusr/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png
Categories=System;TerminalEmulator;
X-TerminalArgExec=--
X-TerminalArgTitle=--title
X-TerminalArgAppId=--class
X-TerminalArgDir=--working-directory
X-TerminalArgHold=--hold
```

If kitty is launched from a keyboard shortcut, change the shortcut command from:

```text
kitty
```

To:

```text
/home/mintusr/.local/bin/kitty-ibus
```

### Self-starting

If IBus switches back to English after reboot, add this command in Linux Mint startup applications:

```bash
sh -c 'sleep 5; ibus engine libpinyin'
```

The time to sleep could also be set by GUI.
