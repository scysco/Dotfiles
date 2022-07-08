local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not installer_ok then
  return
end

-------------------

lsp_installer.setup {
  automatic_installation = true
}

for _, server in ipairs(lsp_installer.get_installed_servers()) do
  lspconfig[server.name].setup {}
end

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
  virtual_text = false,
  update_in_insert = true,
  underline = false,
  severity_sort = true,
}

vim.diagnostic.config(config)
