local colorscheme = "monokaipro"

local status_ok, _ = pcall(require, "monokaipro")
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
-- vim.g.dracula_transparent_bg = true
-- vim.cmd[[colorscheme dracula]]
vim.g.monokaipro_filter = "spectrum"
vim.g.monokaipro_transparent = true
vim.cmd[[colorscheme monokaipro]]
