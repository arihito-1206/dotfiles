-- basic
vim.opt.shell = "/bin/zsh"
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.textwidth = 0
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamed"
vim.cmd('syntax on')

vim.cmd('packadd vim-jetpack')
require('jetpack.plugins')

-- Key map
vim.keymap.set('n', '<C-n>', ':NERDTree<CR>')
vim.keymap.set('n', '[b', ':bprevious<CR>') -- バッファ切り替え
vim.keymap.set('n', ']b', ':bnext<CR>') -- バッファ切り替え

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    io.write("\27[5 q")  -- ESC[5 q = 点滅縦棒（多くのターミナルでデフォルト）
    io.flush()
  end,
})

-- color scheme
-- vim.cmd('colorscheme nightfox')
vim.cmd('colorscheme iceberg')

-- LSP サーバがアタッチされたときのキーマッピング設定
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ctx)
    local set = vim.keymap.set
    set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = true })
    set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = true })
    set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = true })
    set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = true })
    set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = true })
    set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { buffer = true })
    set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { buffer = true })
    set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", { buffer = true })
    set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { buffer = true })
    set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = true })
    set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { buffer = true })
    set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { buffer = true })
    set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", { buffer = true })
    set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { buffer = true })
    set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { buffer = true })
    set("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", { buffer = true })
    set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { buffer = true })
  end,
})

-- プラグインの設定
require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
  -- デフォルトのハンドラ
  function(server_name)
    require("lspconfig")[server_name].setup {}
  end,

  -- `gopls` の特別な設定
  -- GPT に書いてもらった
  ["gopls"] = function()
    require("lspconfig").gopls.setup{
      settings = {
        gopls = {
          gofumpt = true,  -- より厳密なフォーマッタを使用
          analyses = {
            unusedparams = true,  -- 未使用のパラメータを検出
          },
          staticcheck = true,  -- 静的解析を有効化
        },
      },
      on_attach = function(client, bufnr)
        -- フォーマットの自動化
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("GoFormat", {clear = true}),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
        -- インポートの整理の自動化
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("GoOrganizeImports", {clear = true}),
          buffer = bufnr,
          callback = function()
            local params = vim.lsp.util.make_range_params()
            params.context = {only = {"source.organizeImports"}}
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
            for _, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
                else
                  vim.lsp.buf.execute_command(r.command)
                end
              end
            end
          end,
        })
      end,
    }
  end,
}

-- Setup nvim-cmp (自動補完の設定)
-- ref. https://zenn.dev/botamotch/articles/21073d78bc68bf
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    -- { name = "buffer" },
    -- { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<S-TAB>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<TAB>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})
