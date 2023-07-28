return{
    {
        "andymass/vim-matchup"
        config = function()
            vim.g.matchup_matchparen_offscreen = {}
            vim.cmd([[
            omap if i%
            omap af a%
            ]])
        end,
    },
    {
        "LunarWatcher/auto-pairs",
        config = function()
            vim.g.AutoPairsCompatibleMaps = 1
            vim.g.VM_show_warnings = 0
            vim.g.AutoPairs = {'(':')', '[':']', '{':'}', "`":"`", '```':'```', '"""':'"""', "'''":"'''"} 
            vim.g.AutoPairsShortcutToggle = ""
            vim.g.AutoPairsMapSpace = 1
            vim.cmd([[
            nnoremap <leader>tp :AutoPairsToggle<cr>
            ]])
        end,
    },
}
