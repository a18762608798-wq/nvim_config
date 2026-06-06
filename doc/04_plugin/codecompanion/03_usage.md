# usage

## keymaps

```text
Space a c    打开/关闭聊天窗口
Space a d    打开 CodeCompanion 动作菜单
Space a i    inline chat, use to quick revise.
gx           clear the chat window
C c          Stop anwser
```

## tools

### push context

```text
#{buffer} 
Explain this file.
```

All the buffers.

```text
#{selection}
```

当前或最近一次 visual selection。Selection then use `space ac`

```text
#{diff} 
General commit message accord to this diff
```

```text
#{messages} 
刚才 nvim 报错了，帮我分析原因
```

### agent

```text
Use @{grep_search} to find all usages of `RandomMeasAdd`
```

```text
Use @{file_search} to list all Julia files in this project
```

```text
Use @{read_file} to read `src/RandomMeasAdd.jl`, then explain it
```

```text
Use @{insert_edit_into_file} to refactor the code in #{buffer}
```

Which revise the file.

```text
@{web_search} 搜索RandomMeas.jl库的代码注释风格。
```

在用这个工具之前需要配置Tavily API key. 去 Tavily Platform 注册 / 登录，然后在 dashboard 里复制 API key。

`export TAVILY_API_KEY=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`

也可以搜索某个固定的网址.

```text
/fetch https://github.com/bvermersch/RandomMeas.jl/blob/89c492bfb05508e5babe9c8c2c40697995be9e42/src/Estimators.jl#L227-L238
```

```text
Use @{create_file} to create a test file for this module
```

```text
Use @{delete_file} to delete the unused file `old_test.jl`
```

### tools groups

* @{files} 是让 LLM 在当前 working directory 里进行文件操作的一组工具。Which include:

```text
create_file
file_search
get_changed_files
grep_search
insert_edit_into_file
read_file
```

For instance,

```text
@{files} 找到项目里和 RandomMeasAdd 有关的文件，帮我解释整体结构
```

* @{full_stack_dev}

```text
cmd_runner
create_file
file_search
get_changed_files
grep_search
insert_edit_into_file
list_code_usages
read_file
```

这个会给模型更大的权限：能搜、能读、能改、能跑命令。适合明确想让它 agent 式干活的时候。
