SMODS.Joker{
    key = "comedian",
    config = {},
    loc_txt = {
        name = "Comedian",
        text = {
            "{C:chips}+50{} Chips"
        },
        unlock = { "Unlocked by default." }
    },

    atlas = "playz_jokers",
    pos = { x = 0, y = 1 },
    cost = 2,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = 50
            }
        end
    end
}
