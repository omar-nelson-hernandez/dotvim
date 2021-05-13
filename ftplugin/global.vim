if has('nvim')
   au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
 endif
