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
                ignored_next_char = [=[[%(%"%w%%%'%[%"%.%`%$]]=]
            })
            local npairs = require'nvim-autopairs'
            local Rule   = require'nvim-autopairs.rule'
            local cond = require'nvim-autopairs.conds'

            local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
            npairs.add_rules {
                Rule(' ', ' ')
                :with_pair(function (opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({
                        brackets[1][1]..brackets[1][2],
                        brackets[2][1]..brackets[2][2],
                        brackets[3][1]..brackets[3][2],
                    }, pair)
                end)
            }
            for _,bracket in pairs(brackets) do
                npairs.add_rules {
                    Rule(bracket[1]..' ', ' '..bracket[2])
                    :with_pair(function() return false end)
                    :with_move(function(opts)
                        return opts.prev_char:match('.%'..bracket[2]) ~= nil
                    end)
                    :use_key(bracket[2])
                }
            end
            npairs.add_rules {
                Rule('=', '', "-sh")
                :with_pair(cond.not_inside_quote())
                :with_pair(function(opts)
                    local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
                    if last_char:match('[%w%=%s]') then
                        return true
                    end
                    return false
                end)
                :replace_endpair(function(opts)
                    local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
                    local next_char = opts.line:sub(opts.col, opts.col)
                    next_char = next_char == ' ' and '' or ' '
                    if prev_2char:match('%w$') then
                        return '<bs> =' .. next_char
                    end
                    if prev_2char:match('%=$') then
                        return next_char
                    end
                    if prev_2char:match('=') then
                        return '<bs><bs>=' .. next_char
                    end
                    return ''
                end)
                :set_end_pair_length(0)
                :with_move(cond.none())
                :with_del(cond.none())
            }
            end
    },
}
