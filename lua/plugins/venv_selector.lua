return {
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      options = {
        -- 只保留选择标记 + 结果文本，最省空间
        picker_columns = { "marker", "search_result" },

        -- 把超长路径变成短名字；如果有重名，就自动补 parent 目录
        on_fd_result_callback = function(x)
          local function normalize(path)
            return path:gsub("\\", "/"):gsub("/bin/python$", ""):gsub("/Scripts/python.exe$", "")
          end

          local function env_name(path)
            path = normalize(path)
            return vim.fn.fnamemodify(path, ":t")
          end

          local function parent_name(path)
            path = normalize(path)
            return vim.fn.fnamemodify(path, ":h:t")
          end

          local function convert_list(paths)
            local counts = {}
            local normalized = {}

            for _, path in ipairs(paths) do
              local p = normalize(path)
              table.insert(normalized, p)
              local name = env_name(p)
              counts[name] = (counts[name] or 0) + 1
            end

            local out = {}
            for _, p in ipairs(normalized) do
              local name = env_name(p)
              if counts[name] and counts[name] > 1 then
                table.insert(out, string.format("%s (%s)", name, parent_name(p)))
              else
                table.insert(out, name)
              end
            end
            return out
          end

          -- 兼容不同版本/不同调用方式
          if type(x) == "string" then
            local p = normalize(x)
            return env_name(p)
          end

          if type(x) == "table" then
            return convert_list(x)
          end

          return x
        end,
      },
    },
  },
}
