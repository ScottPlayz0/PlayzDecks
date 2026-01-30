SMODS.Joker{
    key = "heartfeltjoker",
    config = {},
    loc_txt = {
        name = "Heartfelt Joker",
        text = {
            "Played cards with",
            "{C:hearts}Heart{} suit give",
            "{C:chips}+35{} Chips when scored"
        },
        unlock = { "Unlocked by default." }
    },

    atlas = "playz_jokers",
    pos = { x = 2, y = 1 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Hearts") then
                return {
                    chips = 35
                }
            end
        end
    end
}
