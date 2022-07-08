-- local colorscheme = "material"
local colorscheme = "tokyonight"

local status_ok, theme = pcall(require, colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

vim.g.tokyonight_style = "night"
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar	= true
vim.cmd[[colorscheme tokyonight]]
