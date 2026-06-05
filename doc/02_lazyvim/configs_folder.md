# the configs folder

To see the structure of the config folder, we install via `sudo apt install tree`

```bash
.
├── init.lua # entrance
├── lazy-lock.json # record the plugins, self-command.
├── lazyvim.json
├── LICENSE
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins
│       └── example.lua
├── README.md
└── stylua.toml
```

主要修改这两个文件的配置：

* lua/config/options.lua：编辑器行为
比如缩进、行号、是否使用系统剪贴板、搜索高亮、鼠标、tab 宽度之类。官方也说明 options.lua 会自动加载。

> NOTICE:
> If you intend to set clipboard, you must get the support of this system,

```bash
echo $XDG_SESSION_TYPE
sudo apt install xclip # If the result is xclip.
sudo apt install wl-clipboard # If the result is wayland.
```

* lua/config/keymaps.lua：快捷键
比如你想改保存、切窗口、找文件、退出终端、删除默认映射，主要都放这里。官方也明确说全局按键映射就在这个文件里配。
