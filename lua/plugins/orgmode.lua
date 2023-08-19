return {
    {'nvim-orgmode/orgmode',
    config = function()
        require('orgmode').setup{}
        require('orgmode').setup_ts_grammar()
        require('orgmode').setup({
            org_agenda_files = {'~/Dropbox/org/*'},
            org_default_notes_file = '~/Dropbox/org/init.org',
        })
    end,
    },
}
