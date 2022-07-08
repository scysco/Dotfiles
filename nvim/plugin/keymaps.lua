local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("n", "<A-Down>", ":m .+1<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-Up>", ":m .-2<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

--Move easily to the end of the line
keymap("i", "<S-Tab>", "<esc>A", opts)

keymap("", "<F12>c", ":exe ':silent !google-chrome-stable %'<CR>", opts)

--Term
keymap("n", "<C-\\>", ":ToggleTerm<CR>", opts)
-- keymap("", "<Esc>", "<C-\><C-n>", opts)
vim.cmd [[
  tnoremap <Esc> <C-\><C-n>:ToggleTerm<CR>
]]
