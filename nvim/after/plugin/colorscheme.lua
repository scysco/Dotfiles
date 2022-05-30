local colorscheme = "dracula"

local status_ok, _ = pcall(require, "dracula")
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
vim.g.dracula_transparent_bg = true
vim.cmd[[colorscheme dracula]]
