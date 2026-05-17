# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

| 目录             | 放什么                                                                 |
| -------------- | ------------------------------------------------------------------- |
| `lua/plugins/` | Lazy.nvim 插件声明，也就是 `return { { "插件名", opts = ..., config = ... } }` |
| `lua/utils/`   | 你自己写的普通 Lua 函数，不直接声明插件                                              |
| `lua/config/`  | 全局配置，比如 options、keymaps、autocmds，LazyVim 常见结构里会有                    |
