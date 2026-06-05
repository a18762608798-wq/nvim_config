# Chapter 4 mode and register

## 4.1 mode

* Normal mode
* Insert mode
* Visual mode
* Ex mode: `:` start, which is the command line mode.

### 4.1.1 Insert mode

* `o`: enter insert mode below current line.
* `O`: enter insert mode up current line.
* `a`: enter insert mode after the cursor.
* `A`: enter insert mode at the end of the line.
* `i`: enter insert mode before the cursor.
* `I` enter insert mode at the beginning of the line.

### 4.1.2 Normal mode

#### 4.1.2.1 single key command

* `hjkl`: move the cursor.
* `w`: move the cursor to the latter word.  
* `b`: move the cursor to the before word.
* `e`: move the cursor to the end of next word.
* `0`: move the cursor to the beginning of the line.
* `^`: move the cursor to the first characters of the line.
* `$`: move the cursor to the end of this line.
* `f`: search backward, use `;` or `'` to choose.
* `F`: search forward.
* `y`: copy
* `p`: paste after the cursor.

#### 4.1.2.2 combo

Similar as:

$$
y + ? = combo
$$

* `y` + `k`: copy the current line and the above line.
* `y` + `w` or `e`: copy the end of current word.
* `y` + `i` +`w`: copy the current word.
* `y` + `a` + `w`: copy the current word and the space after it.
* `y` + `10` + `l`: copy 10 characters after the cursor.
* `y` + `t` + `,`: copy until the next `,` but not including it.
* `y` + `f` + `,`: copy until the next `,`
* `Y` or `y` + `$`: copy the rest of the line.
* `y` + `3` + `y`: copy 3 lines.
* `100` + `p`: paste 100 times.
* `P`: paste before the cursor.

#### 4.1.2.3 browse

* `G`: move to the end of the file.
* `gg`: move to the beginning of the file.
* `100` + `j`: move down 100 lines.
* `Ctrl` + `u`: move up half a page.
* `Ctrl` + `d`: move down half a page.
* `Ctrl` + `f`: move down a page.
* `Ctrl` + `b`: move up a page.

#### 4.1.2.4 edit

* `d`: refer to `y` for the combo.
* `c` + `a` + `w`: change the current word and the space after it, then enter insert mode.
* `r`: replace a single character.
* `R`: similarly as insert mode of general computer.
* `4` + `>` + `>`: indent 4 spaces.
* `4` + `<` + `<`: cancel indent 4 spaces.
* `u`: undo.
* `Ctrl` + `r`: redo.

### 4.1.3 Visual mode

#### 4.1.3.1 choose

* `v` + `hjkl`: select characters.
* `v` + `o`: change the direction of selection.
* `V`: choose a line.
* `Ctrl` + `v`: select a block, then you can use `I` or `A` to add text to every line.
* `V` + `>`: move the selected lines to the right.

### 4.1.4 Ex mode

#### 4.1.4.1 command line

Press `:` to enter command line mode, then you can input commands.

* `q`: exit neovim.
* `q!`: forcefully exit neovim without saving.
* `wq`: save and exit.
* `q:`: edit the command line history.
* `:1,10d`: delete lines 1 to 10.
* `:%d`: delete all lines.

#### 4.1.4.2 search

Press `/` to search forward, and `?` to search backward. Then you can input the keyword.

* `enter`: start to jump to the next match.
* `n`: jump to the next match.
* `N`: jump to the previous match.
* `Esc`: cancel the search highlight.

### 4.1.5 register

It is so difficult so I do not want to write it down until I use it.
