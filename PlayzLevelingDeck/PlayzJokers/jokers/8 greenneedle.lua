SMODS.Joker{
    key = "greenneedle",
    loc_txt = {
        name = "Green Needle",
        text = {
            "Copies the ability",
            "of rightmost {C:attention}Joker{}"
        },
        unlock = {"Unlocked by default."}
    },

    atlas = "playz_jokers",
    pos = { x = 1, y = 0 },
    cost = 10,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,

    calculate = function(self, card, context)
        local target_joker

        for i = #G.jokers.cards, 1, -1 do
            local j = G.jokers.cards[i]
            if j ~= card then
                target_joker = j
                break
            end
        end
        if not target_joker then return end
        return SMODS.blueprint_effect(card, target_joker, context)
    end
}
