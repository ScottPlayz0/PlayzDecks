SMODS.Joker{
    key = "enragedjoker",
    config = {},
    loc_txt = {
        name = "Enraged Joker",
        text = {
            "Played cards with",
            "{C:spades}Spade{} suit give",
            "{C:chips}+35{} Chips when scored"
        },
        unlock = { "Unlocked by default." }
    },

    atlas = "playz_jokers",
    pos = { x = 3, y = 1 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Spades") then
                return {
                    chips = 35
                }
            end
        end
    end
}