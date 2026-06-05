# set up

The function is own to terminal. We recommend to use kitty.

## install kitty

```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

它会装到 Linux 的 `~/.local/kitty.app`。([Kovid's Software Projects][1])

把命令加到 PATH：

```bash
mkdir -p ~/.local/bin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty
ln -sf ~/.local/kitty.app/bin/kitten ~/.local/bin/kitten
```

Kitty 官方建议用软链接，不要把二进制文件直接拷出去。([Kovid's Software Projects][1])

设成默认终端：

```bash
mkdir -p ~/.local/share/applications ~/.config
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty.desktop
echo 'kitty.desktop' > ~/.config/xdg-terminals.list
```

装完验证：

```bash
kitty --version
```
