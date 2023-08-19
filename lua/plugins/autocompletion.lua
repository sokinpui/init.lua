return {
  {
    'SirVer/ultisnips',
    init = function()
      vim.g.UltiSnipsExpandTrigger = "<C-j>"
      vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-buffer',
      'FelipeLema/cmp-async-path',
      'hrsh7th/cmp-nvim-lsp',
      --'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-calc',
      'onsails/lspkind-nvim',
      {
        "quangnguyen30192/cmp-nvim-ultisnips",
        config = function()
          -- optional call to setup (see customization section)
          require("cmp_nvim_ultisnips").setup{}
        end,
      },
    },
    config = function()
      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require 'cmp'
      --local lspkind = require('lspkind')

      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        sources = {
          {
            name = 'buffer',
            keyword_length = 1,
            option = {
              keyword_length = 5,
              --keyword_pattern = [[\k\+]],
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            }
          },
          { name = 'nvim_lsp' },
          { name = "ultisnips" },
          --{ name = 'cmdline' },
          { name = 'async_path' },
          { name = 'calc' },
          --{ name = 'orgmode' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<c-e>'] = cmp.mapping({
            i = function(fallback)
              cmp.close()
              fallback()
            end
          }),
          ["<Tab>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end,
          }),
          ["<S-Tab>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
              else
                fallback()
              end
            end,
          }),
          ['<C-n>'] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end
          }),
          ['<C-p>'] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end
          }),
        }),
      }
      --cmp.setup.cmdline(':', {
      --  completion = { autocomplete = false },
      --  sources = cmp.config.sources({
      --    { name = 'async_path' }
      --  }, {
      --    { name = 'cmdline' }
      --  })
      --})
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'async_path' }
        }, {
          { name = 'cmdline' },
        }),
        enabled = function()
          -- Set of commands where cmp will be disabled
          local disabled = {
            --IncRename = true
          }
          -- Get first word of cmdline
          local cmd = vim.fn.getcmdline():match("%S+")
          -- Return true if cmd isn't disabled
          -- else call/return cmp.close(), which returns false
          return not disabled[cmd] or cmp.close()
        end
      })
    end
  },
} 

