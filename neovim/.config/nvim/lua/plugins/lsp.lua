-- Nvim-LSP: Quickstart configs for Nvim LSP
return {
  "neovim/nvim-lspconfig",
  priority = 99,
  config = function(_, opts)
    vim.diagnostic.config({
      virtual_lines = { current_line = true }
      -- virtual_text = { current_line = true }
    })

    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
          vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
        end

        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set('n', '<leader>i', function()
          vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
        end, opts)
        vim.keymap.set('n', '<leader>ih', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, opts)
      end,
    })

    local elixir_path = nil
    if vim.fn.executable('elixir-ls') == 1 then
      elixir_path = { 'elixir-ls' }
    end

    require 'lspconfig'.biome.setup({})
    require 'lspconfig'.clangd.setup({})
    require 'lspconfig'.elixirls.setup({
      cmd = elixir_path,
    })
    require('lspconfig').gdscript.setup({})
    require('lspconfig').gopls.setup({})
    require 'lspconfig'.lua_ls.setup({
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
    })
    require('lspconfig').pylsp.setup({
      settings = {
        pylsp = {
          plugins = {
            autopep8 = {
              enabled = false
            },
            flake8 = {
              enabled = false
            },
            mccabe = {
              enabled = false
            },
            pycodestyle = {
              enabled = false
            },
            pyflakes = {
              enabled = false
            },
            pylint = {
              enabled = false
            },
            yapf = {
              enabled = false
            }
          }
        }
      }
    })
    require('lspconfig').ruff.setup({})
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
    require 'lspconfig'.svelte.setup({})
    require 'lspconfig'.tailwindcss.setup({
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
    require 'lspconfig'.terraformls.setup({})
    require 'lspconfig'.texlab.setup({
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
      settings = {
        zls = {
          enable_build_on_save = true,
          build_on_save_args = { "check" }
        }
      }
    })
  end
}
