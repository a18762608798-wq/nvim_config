# config

## perview latex expression

Install related dependence.

In your bash, install a python package:

```bash
sudo apt install python3-pylatexenc
```

Then install parser in neovim.

```bash
:tsinstall markdown markdown_inline latex
```

## close the MD013 and so on

Firstly, create a markdownlint configuration file in your nvim config directory, ref to `~/.config/nvim/lua/plugins/lint.lua`

Then add the global configuration file, ref to `~/.config/nvim/.markdownlint.yaml`
