# Tools groups

### `@{files}`

`@{files}` 是文件操作工具组，适合让 LLM 在当前 working directory 里搜、读、创建、修改文件。

包含：

```text
create_file
file_search
get_changed_files
grep_search
insert_edit_into_file
read_file
```

例子：

```text
@{files} 找到项目里和 RandomMeasAdd 有关的文件，帮我解释整体结构。
```

```text
@{files} 读取相关源码，帮我设计一个测试文件。
```

```text
@{files} 根据 #{diff} 总结这次改动，并指出可能的 bug。
```

### `@{agent}`

`@{agent}` 是更完整的 agent mode。它会给模型更大的权限：能问问题、能搜、能读、能改、能跑命令、能看 diagnostics。

包含：

```text
ask_questions
create_file
delete_file
file_search
get_changed_files
get_diagnostics
grep_search
insert_edit_into_file
read_file
run_command
```

适合明确希望它 agent 式干活的时候。

例子：

```text
@{agent} 找到 RandomMeasAdd 的实现、测试和调用位置，解释整体结构，然后提出重构建议。
```

```text
@{agent} 查看当前 git diff，运行相关测试，并告诉我是否可以提交。
```

```text
@{agent} 修复当前文件的 LSP diagnostics。必要时读取相关文件，但修改前先说明计划。
```

```text
@{agent} 根据当前项目结构，为这个模块补一个最小测试文件。
```

注意：`@{agent}` 不等于无限权限。运行命令、删文件、改文件等操作通常仍然需要确认。
