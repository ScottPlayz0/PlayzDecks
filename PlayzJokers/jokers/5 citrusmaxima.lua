SMODS.Joker{
    key = "citrus_maxima",
    in_pool = function(self)
        return not (G.GAME and G.GAME.citrus_maxima_destroyed)
    end,
    config = {
        extra = {
            chips = 150,
            odds = 6
        }
    },

    loc_txt = {
        name = "Citrus Maxima",
        text = {
            "{C:chips}+150{} Chips",
            "{C:green}1 in 6{} chance this",
            "card is destroyed",
            "at end of round"
        },
        unlock = { "Unlocked by default." }
    },

    atlas = "playz_jokers",
    pos = { x = 2, y = 0 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,

    loc_vars = function(self, _, card)
        local odds = (card and card.ability.extra.odds) or self.config.extra.odds
        if SMODS.get_probability_vars then
            local ok, n, d = pcall(
                SMODS.get_probability_vars,
                card, 1, odds, "j_modprefix_citrus_maxima"
            )
            if ok then
                return { vars = { n, d } }
            end
        end
        return { vars = { 1, odds } }
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return { chips = self.config.extra.chips }
        end
        if context.end_of_round and context.main_eval and not context.game_over then
            if SMODS.pseudorandom_probability(
                card,
                "group_citrus_maxima",
                1,
                card.ability.extra.odds,
                "j_modprefix_citrus_maxima"
            ) then
                G.GAME.citrus_maxima_destroyed = true
                card.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_dissolve({ G.C.RED }, nil, 1.6)
                        card_eval_status_text(
                            card,
                            "extra",
                            nil, nil, nil,
                            { message = "Destroyed!", colour = G.C.RED }
                        )
                        return true
                    end
                }))
            end
        end
    end
}
