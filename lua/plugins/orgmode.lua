return {
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
      {
        'akinsho/org-bullets.nvim',
        config = function()
          require('org-bullets').setup()
        end
      },
      {
        'sokinpui/orgmode-multi-key',
        config = function()
          require('orgmode-multi-key').setup()
        end
      }
    },
    config = function()
      -- Load treesitter grammar for org
      require('orgmode').setup_ts_grammar()

      require('orgmode').setup({
        org_agenda_files = '~/Task-manage/**/*',
        org_default_notes_file = '~/Task-manage/index.org',
        org_highlight_latex_and_related = "entities",
        org_hide_leading_stars = true,
      })
    end,
  }
}
