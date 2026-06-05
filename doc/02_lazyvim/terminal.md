# the terminal in lazyvim

现在的 LazyVim 默认终端这样用：

* `Space f t`：打开/切换**项目根目录**终端。LazyVim 默认 `<leader>` 就是 `Space`。
* `Space f T`：打开**当前工作目录**终端。
* `Ctrl + /`：关闭或者打开终端。

一个最常见的使用流程是：

1. 按 `Space f t`
2. 直接在里面跑命令，比如 `git status`、`npm run dev`
3. 想回到普通编辑操作时，按 `Ctrl-\` 再按 `Ctrl-n`，退出终端输入模式。Neovim 的终端模式就是这样返回普通模式的。
4. 回到普通模式后，可以继续切窗口、编辑文件；例如 LazyVim 默认用 `Ctrl-h/j/k/l` 在窗口间移动。

再补两个要点：

* 当前 LazyVim 的默认终端实现已经是 `Snacks.terminal()`，不是老版本里常见的 toggleterm 配置。
* 在 Neovim 终端里，进入“终端输入”可用 `i`、`a`、`I`、`A` 或 `:startinsert`；退出则是 `Ctrl-\ Ctrl-n`。
