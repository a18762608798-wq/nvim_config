# 常用命令

### 打开 chat

```vim
:CodeCompanionChat
```

### Toggle chat

```vim
:CodeCompanionChat Toggle
```

### Inline 修改

```vim
:CodeCompanion <prompt>
```

Visual selection 后可以直接：

```vim
:'<,'>CodeCompanion /fix
:'<,'>CodeCompanion /explain
```

### 动作菜单

```vim
:CodeCompanionActions
```

### 常用 prompt library

```vim
:CodeCompanion /commit
:CodeCompanion /explain
:CodeCompanion /fix
:CodeCompanion /lsp
:CodeCompanion /tests
```
