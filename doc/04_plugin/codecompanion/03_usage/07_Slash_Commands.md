# `/`：Slash Commands

`/` 是你手动触发的 chat buffer 命令，常用于插入上下文或控制会话。

### 添加 buffer

```text
/buffer
```

用于从打开的 buffers 里选择一个或多个加入 chat。

### 添加文件

```text
/file
```

用于从当前 working directory 里选择文件加入 chat。

### 添加 URL 内容

```text
/fetch https://github.com/bvermersch/RandomMeas.jl/blob/89c492bfb05508e5babe9c8c2c40697995be9e42/src/Estimators.jl#L227-L238
```

适合读取某个固定网页、GitHub 文件、文档页面。

### 添加 symbols outline

```text
/symbols
```

适合只给模型文件结构，而不是完整文件内容，节省 token。

### 添加图片

```text
/image
```

适合支持 vision 的模型。

### 压缩对话历史

```text
/compact
```

把长对话总结成较短上下文，适合 chat 很长以后继续工作。

### fork 当前对话

```text
/fork
```

复制当前 chat buffer，用来尝试不同方向但保留原对话。

### 插入当前时间

```text
/now
```

### 添加 Vim help

```text
/help
```

例如查 Neovim help tag 后发给 LLM。

### rules

```text
/rules
```

给当前 chat 加规则组，例如项目约定、代码风格、测试要求等。

### MCP

```text
/mcp
```

启动/停止 MCP servers。MCP tools 通常会以 `@{mcp:...}` 的形式出现在工具补全里。

### 分享 chat

```text
/share
```

把当前 chat 分享成 secret GitHub Gist，需要配置 token。

### ACP 相关 slash commands

这些只在 ACP adapter 场景常用，例如 Claude Code / Gemini CLI / Opencode 一类 agent：

```text
/command
/mode
/resume
/acp_session_options
```
