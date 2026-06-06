# Keymaps

这些是我在 LazyVim 里的 CodeCompanion 快捷键：

```text
<Space> a c    打开/关闭聊天窗口
<Space> a d    打开 CodeCompanion 动作菜单
<Space> a i    inline chat，用来快速修改当前代码
gx             清空 chat window
<C-c>          停止回答 / 关闭
```

CodeCompanion chat buffer 里常用默认键：

```text
<CR> / <C-s>   发送消息
gx             清空聊天内容
gd             打开 debug window，查看实际发送给 LLM 的消息、上下文、adapter 设置等
ga             切换 adapter / model
gr             重新生成上一条回答
gy             yank 最近的 code block
[[ / ]]        在回答之间跳转
{ / }          在不同 chat buffer 之间切换
?              查看当前 chat buffer 可用 keymaps
```
