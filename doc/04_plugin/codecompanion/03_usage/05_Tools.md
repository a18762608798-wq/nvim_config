# `@`：Tools

`@` 用来给 LLM 工具能力。模型可以调用工具来读文件、搜文件、改文件、跑命令等。

### 搜文本：`grep_search`

```text
Use @{grep_search} to find all usages of `RandomMeasAdd`.
```

适合找函数、类型、变量、报错字符串。

### 搜文件：`file_search`

```text
Use @{file_search} to list all Julia files in this project.
```

例子：

```text
Use @{file_search} to find files related to measurement estimators.
```

### 读文件：`read_file`

```text
Use @{read_file} to read `src/RandomMeasAdd.jl`, then explain it.
```

### 修改文件：`insert_edit_into_file`

```text
Use @{insert_edit_into_file} to refactor the code in #{buffer}.
```

也可以配合 `@{files}`：

```text
@{files} Refactor the current buffer according to this requirement: ...
```

注意：修改文件通常会要求确认。

### 创建文件：`create_file`

```text
Use @{create_file} to create a test file for this module.
```

### 删除文件：`delete_file`

```text
Use @{delete_file} to delete the unused file `old_test.jl`.
```

注意：删除文件是 destructive action，通常需要确认。

### 查看 git diff：`get_changed_files`

```text
@{get_changed_files} 查看当前 git diff，并总结修改点。
```

适合 review、commit message、解释当前改动。

### 运行命令：`run_command`

```text
@{run_command} 执行 `git diff --no-ext-diff`，然后总结 diff 内容。
```

运行测试：

```text
@{run_command} run `pytest`
```

Julia 项目：

```text
@{run_command} run `julia --project -e 'using Pkg; Pkg.test()'`
```

注意：`run_command` 是真正在本机执行命令，默认需要你授权。

### 查看 diagnostics：`get_diagnostics`

```text
Use @{get_diagnostics} to check for any issues in the current file.
```

适合让模型先看 LSP 报错再修复。

### Web search：`web_search`

```text
@{web_search} 搜索 RandomMeas.jl 库的代码注释风格。
```

需要配置 Tavily API key，例如：

```bash
export TAVILY_API_KEY=...
```

### Fetch webpage：`fetch_webpage`

```text
Use @{fetch_webpage} to read the latest Neovim documentation and summarize it.
```

注意：这是 tool 形式的网页读取；slash command 形式是 `/fetch`。

### Memory：`memory`

```text
Use @{memory} to remember project conventions for this repository.
```

是否可用取决于你的配置；默认有路径限制，通常只允许访问特定 memory 目录或白名单路径。
