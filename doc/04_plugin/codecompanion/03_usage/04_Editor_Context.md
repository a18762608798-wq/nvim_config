# `#`：Editor Context

`#` 用来把 Neovim 里的上下文发给 LLM。

### 当前 buffer

```text
#{buffer}
Explain this file.
```

指定某个 buffer / 文件名 / 路径：

```text
#{buffer:init.lua}
#{buffer:src/main.rs}
#{buffer:utils}
```

只发送 diff，节省 token：

```text
#{buffer}{diff}
```

发送完整内容：

```text
#{buffer}{all}
```

### 所有打开的 buffers

```text
#{buffers}
Explain how these files work together.
```

### 当前或最近一次 visual selection

```text
#{selection}
Explain this selected code.
```

用法：

```text
先 visual select 一段代码，然后 <Space> a c 打开 chat，再输入：
#{selection} 解释这段代码
```

### Git diff

```text
#{diff}
Generate a commit message according to this diff.
```

也可以：

```text
#{diff}
Review this diff and point out potential bugs.
```

### Neovim messages

```text
#{messages}
刚才 nvim 报错了，帮我分析原因。
```

### LSP diagnostics

```text
#{diagnostics}
解释当前文件的 LSP 报错，并给出修复建议。
```

### quickfix list

```text
#{quickfix}
根据 quickfix list 里的错误，帮我定位问题。
```

适合 compiler errors、grep results、LSP diagnostics 聚合结果。

### terminal 输出

```text
#{terminal}
这是刚才终端里的输出，帮我分析失败原因。
```

注意：`#{terminal}` 是"分享终端输出"，不是"让模型执行命令"。要执行命令用 `@{run_command}`。

### 当前屏幕 viewport

```text
#{viewport}
根据我当前屏幕看到的内容，帮我解释这里发生了什么。
```
