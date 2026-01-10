SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "leveling_deck",
    px = 71,
    py = 95,
    path = "leveling_deck.png"
})

SMODS.Back{
    name = "Leveling Deck",
    key = "leveling_deck",
    atlas = "leveling_deck",
    pos = {x = 0, y = 0},
    config = {joker_slot = -3, add_joker_slot = 1, ante= -0},
    loc_txt = {
        name = "Leveling Deck",
        text={
            "Start with {C:attention}-3 Joker slots{}",
            "After defeating each {C:attention}Boss Blind{},",
            "Increase {C:attention}Joker slots by 1{}"
        },
    },
    calculate = function(self, back, context)
        if context.context == "eval" and G.GAME.last_blind.boss then
            G.jokers.config.card_limit = G.jokers.config.card_limit + self.config.add_joker_slot
        end
    end,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                ease_ante(-0)
                return true
            end
        }))
    end
}