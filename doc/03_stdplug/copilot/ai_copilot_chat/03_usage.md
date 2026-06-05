# usage

## Keymaps

`<leader>aa`   打开/关闭 chat
`<leader>aq`   quick chat
`<leader>ap`   prompt actions
`<leader>ax`   clear chat
`<C-s>`        在 chat buffer 提交 prompt
`enter` Allow agent use tools.

## prompt

```text
/Explain   解释代码
/Review    代码审查
/Fix       修复问题
/Optimize  优化代码
/Docs      生成文档注释
/Tests     生成测试
/Commit    基于 staged changes 生成 commit message
```

## Tools in AI copilot chat

**Core thinking: use basic tools clearly specify the range. Then let copilot to edit.**

### Basic tools

* current buffer.

```text
#buffer:active
Explain this file.
```

* all the buffers

```text
#buffer:listed
Explain how these open files relate to each other.
```

* the buffer visible

```text
#buffer:visible
Compare these visible files.
```

* Push the designated file.

```text
#file:./00_inbox/soft_line_break.md
```

Use tap to quick choose the choice.

* Grep content

```text
#grep:terminal
Explain where terminal is used in Chinese.
```

* Get the https url

```text
#url:https://github.com/bvermersch/RandomMeas.jl/issues/72
Summarize this page in Chinese.
```

### agent

#### basic usage

```text
@copilot
Find where kitty in this project. Use grep/file only. Do not edit files. Anwser me in Chinese.
```

NOTE: 会让模型可以调用 bash、edit、file、glob、grep、gitdiff 等 workspace functions；默认工具调用需要手动批准。**Then use `enter` to allow use these tools**.

The tools include: edit, bash and so on.

#### prompt cases

```text
@copilot
#buffer:active

Use the edit tool to change README.md.
Replace the exact text "Hi" with "AI".
```

```text
@copilot
#buffer:active

Use the edit tool to add docs for function in this julia file.
```
