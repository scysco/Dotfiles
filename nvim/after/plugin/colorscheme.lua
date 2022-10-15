-- local colorscheme = "material"
local colorscheme = "tokyonight"

local status_ok, theme = pcall(require, colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

require("tokyonight").setup({
  style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  transparent = true, -- Enable this to disable setting the background color
})

--vim.g.tokyonight_style = "night"
--vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar	= true
vim.cmd[[colorscheme tokyonight]]
--vim.cmd[[highlight Normal guibg=none]]
