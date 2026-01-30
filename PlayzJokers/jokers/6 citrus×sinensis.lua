SMODS.Joker{
    key = "citrus_sinensis",
    in_pool = function(self)
        return G.GAME and G.GAME.citrus_maxima_destroyed == true
    end,
    config = {
        extra = {
            xchips0 = 3,
            odds = 1000
        }
    },

    loc_txt = {
        name = "Citrus × Sinensis",
        text = {
            "{X:chips,C:white}x3{} Chips",
            "{C:green}1 in 1000{} chance this",
            "card is destroyed",
            "at end of round"
        },
        unlock = {"Unlocked by default."}
    },

    atlas = "playz_jokers",
    pos = { x = 3, y = 0 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,

    loc_vars = function(self, info_queue, card)
        local odds = nil
        if card and card.ability and card.ability.extra and card.ability.extra.odds then
            odds = card.ability.extra.odds
        elseif self and self.config and self.config.extra and self.config.extra.odds then
            odds = self.config.extra.odds
        else
            odds = 1
        end
        if card and SMODS.get_probability_vars then
            local ok, n, d = pcall(SMODS.get_probability_vars, card, 1, odds, "j_modprefix_citrus_sinensis")
            if ok and n and d then
                return { vars = { n, d } }
            end
        end
        return { vars = { 1, odds } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return { x_chips = 3 }
        end
        if context.end_of_round and not context.game_over and context.main_eval then
            if SMODS.pseudorandom_probability(
                card,
                "group_citrus_sinensis",
                1,
                (card and card.ability and card.ability.extra and card.ability.extra.odds)
                or (self.config and self.config.extra and self.config.extra.odds)
                or 1,
                "j_modprefix_citrus_sinensis",
                false
            ) then
                SMODS.calculate_effect({ func = function()
                    if card then
                        card.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card:start_dissolve({ G.C.RED }, nil, 1.6)
                                return true
                            end
                        }))
                        card_eval_status_text(card, "extra", nil, nil, nil,
                            { message = "Destroyed!", colour = G.C.RED }
                        )
                    end
                    return true
                end }, card)
            end
        end
    end
}
