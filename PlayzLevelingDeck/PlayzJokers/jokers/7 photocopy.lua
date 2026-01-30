SMODS.Joker{
    key = "photocopy",

    loc_txt = {
        name = "Photocopy",
        text = {
            "Copies ability of",
            "{C:attention}Joker{} to the left"
        },
        unlock = {"Unlocked by default."}
    },

    atlas = "playz_jokers",
    pos = { x = 0, y = 0 },
    cost = 10,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,

    calculate = function(self, card, context)
        local my_pos
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_pos = i
                break
            end
        end
        if not my_pos or my_pos <= 1 then return end
        local target_joker = G.jokers.cards[my_pos - 1]
        if not target_joker then return end
        return SMODS.blueprint_effect(card, target_joker, context)
    end
}
