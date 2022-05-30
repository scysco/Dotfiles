local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not installer_ok then
  return
end

local cmp_lsp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_lsp_ok then
  return
end

lsp_installer.on_server_ready(function(server)
  local opts = {}

  server:setup(opts)
  vim.cmd([[ do User LspAttachBuffers ]])
end)

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  --virtual_text = false,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
}

vim.diagnostic.config(config)

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_lsp.update_capabilities(capabilities)
