-- Nvim-LSP: Quickstart configs for Nvim LSP
return {
  "neovim/nvim-lspconfig",
  config = function(_, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<M-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })

    local on_attach = function(client, bufnr)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.buf.inlay_hint(bufnr, true)
      end
    end

    local elixir_path = nil
    if vim.fn.executable('elixir-ls') == 1 then
      elixir_path = { 'elixir-ls' }
    end

    require 'lspconfig'.biome.setup({
      on_attach = on_attach,
    })
    require 'lspconfig'.clangd.setup({
      on_attach = on_attach,
    })
    require 'lspconfig'.elixirls.setup({
      cmd = elixir_path,
      on_attach = on_attach
    })
    require 'lspconfig'.lua_ls.setup({
      on_attach = on_attach,
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
          client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
            Lua = {
              runtime = {
                version = 'LuaJIT'
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                }
                -- library = vim.api.nvim_get_runtime_file("", true)
              }
            }
          })

          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
      end
    })
    require('lspconfig').omnisharp.setup({
      cmd = { "omnisharp" },
      on_attach = on_attach,
    })
    require('lspconfig').pylsp.setup({
      on_attach = on_attach,
    })
    -- NOTE: Disabled as we use 'rustaceanvim'
    --require('lspconfig').rust_analyzer.setup({
    --  settings = {
    --    ['rust-analyzer'] = {
    --      check = {
    --        command = "clippy"
    --      }
    --    },
    --  },
    --})
    require 'lspconfig'.svelte.setup({
      on_attach = on_attach,
    })
    require 'lspconfig'.tailwindcss.setup({
      on_attach = on_attach,
      init_options = {
        userLanguages = {
          elixir = "html-eex",
          eelixir = "html-eex",
          eruby = 'erb',
          heex = "phoenix-heex",
        }
      }
    })
    local forwardSearch = { executable = '', args = {} }
    if vim.loop.os_uname().sysname == "Darwin" then
      forwardSearch = {
        executable = '/Applications/Skim.app/Contents/SharedSupport/displayline',
        args = { "-g", "%l", "%p", "%f" }
      }
    end
    require 'lspconfig'.texlab.setup({
      on_attach = on_attach,
      settings = {
        texlab = {
          auxDirectory = ".",
          bibtexFormatter = "texlab",
          build = {
            args = {
              "-pdf",
              "-interaction=nonstopmode",
              "-synctex=1",
              "-pv",
              "%f"
            },
            executable = "latexmk",
            forwardSearchAfter = true,
            onSave = true
          },
          chktex = {
            onOpenAndSave = true
          },
          diagnosticsDelay = 300,
          formatterLineLength = 80,
          forwardSearch = forwardSearch,
          latexFormatter = "latexindent",
          latexindent = {
            modifyLineBreaks = false
          }
        },
      }
    })
    require 'lspconfig'.zls.setup({
      on_attach = on_attach,
    })
  end
}
