return{
    {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_matchparen_offscreen = {}
            vim.cmd([[
            omap if i%
            omap af a%
            ]])
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup({
                map_bs = false,
                enable_check_bracket_line = false,
                ignored_next_char = [=[[%(%"%w%%%'%[%"%.%`%$]]=],
            })
            require("plugins.config.nvim-autopairs")
        end
    },
}