-- local colorscheme = "material"
local colorscheme = "tokyonight"

local status_ok, theme = pcall(require, colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- theme.setup({
-- 	contrast = {
-- 		popup_menu = true, -- Enable lighter background for the popup menu
-- 	},
--
-- 	italics = {
-- 		comments = true, -- Enable italic comments
-- 	},
--
-- 	disable = {
-- 		background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
-- 	},
--
-- 	lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )
--
-- 	async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)
--
-- 	custom_highlights = {} -- Overwrite highlights with your own
-- })
--
-- vim.g.material_style = "deep ocean"
-- vim.cmd[[colorscheme material]]

vim.g.tokyonight_style = "night"
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar	= true
vim.cmd[[colorscheme tokyonight]]
