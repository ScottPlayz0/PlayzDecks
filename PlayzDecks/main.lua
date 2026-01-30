-- Shared Mod Icon Atlas
SMODS.Atlas({
    key = "modicon",
    path = "ModIcon.png",
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "scaling_decks",
    px = 71,
    py = 95,
    path = "scaling_decks.png"
})

SMODS.Back{
    name = "Leveling Deck",
    key = "leveling_deck",
    atlas = "scaling_decks",
    pos = {x = 0, y = 0},
    config = {joker_slot = -3, add_joker_slot = 1, ante = -0},
    loc_txt = {
        name = "Leveling Deck",
        text = {
            "Start with {C:red}-3 Joker slots{}",
            "After defeating each", 
            "{C:attention}Boss Blind{},",
            "gain {C:attention}+1 Joker slots{}"
        },
    },
    calculate = function(self, back, context)
        if context.context == "eval" and G.GAME.last_blind.boss then
            G.jokers.config.card_limit =
                G.jokers.config.card_limit + self.config.add_joker_slot
        end
    end,
}


SMODS.Back{
    name = "Hoarder Deck",
    key = "hoarder_deck",
    atlas = "scaling_decks",
    pos = {x = 1, y = 0},
    config = {},
    loc_txt = {
        name = "Hoarder Deck",
        text = {
            "Start with {C:red}-2 Consumable slots{},",
            "and {C:red}-1 Hand Size{}.",
            "After each {C:attention}Boss Blind{}, gain",
            "{C:attention}+1 Hand Size{}, {C:attention}+1 Consumable slot{}"
        }
    },

    calculate = function(self, back, context)
        if context.context == "eval"
        and G.GAME.last_blind
        and G.GAME.last_blind.boss then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.hand then
                        G.hand:change_size(1)
                    end
                    if G.consumeables and G.consumeables.config then
                        G.consumeables.config.card_limit =
                            (G.consumeables.config.card_limit or 0) + 1
                    end
                    return true
                end
            }))
        end
    end,

    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.hand then
                    G.hand:change_size(-1)
                end
                if G.consumeables and G.consumeables.config then
                    G.consumeables.config.card_limit =
                        (G.consumeables.config.card_limit or 0) - 2
                end
                return true
            end
        }))
    end
}


SMODS.Back{
    name = "Shattered Deck",
    key = "shattered_deck",
    atlas = "scaling_decks",
    pos = {x = 2, y = 0},
    loc_txt = {
        name = "Shattered Deck",
        text = {
            "{C:red}Heavily Reduced starting stats{}",
            "{C:attention}Increase{} lost stats after ",
            "defeating the {C:attention}Boss Blind{}",
            "{C:purple}+0.5 in certain stats works like +0{}"
        }
    },

    calculate = function(self, back, context)
        if context.context == "eval"
        and G.GAME.last_blind
        and G.GAME.last_blind.boss then
            if G.jokers and G.jokers.config then
                G.jokers.config.card_limit =
                    G.jokers.config.card_limit + 0.5
            end
            if G.consumeables and G.consumeables.config then
                G.consumeables.config.card_limit =
                    G.consumeables.config.card_limit + 0.5
            end
            if G.GAME and G.GAME.starting_params then
                G.GAME.starting_params.joker_slots =
                    (G.GAME.starting_params.joker_slots or 2) + 0.5
                G.GAME.starting_params.consumable_slots =
                    (G.GAME.starting_params.consumable_slots or 1) + 0.5
            end
            if G.hand then
                G.hand:change_size(1)
            end
            if G.GAME then
                G.GAME.round_resets.hands =
                    (G.GAME.round_resets.hands or 0) + 0.5
                ease_hands_played(0.5)
                G.GAME.round_resets.discards =
                    (G.GAME.round_resets.discards or 0) + 0.5
                ease_discard(0.5)
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.change_play_limit(0.5)
                    SMODS.change_discard_limit(0.5)
                    return true
                end
            }))
        end
    end,

    apply = function(self, back)
        if G.GAME.starting_params then
            G.GAME.starting_params.hands =
                (G.GAME.starting_params.hands or 4) - 1
            G.GAME.starting_params.joker_slots =
                (G.GAME.starting_params.joker_slots or 5) - 3
            G.GAME.starting_params.consumable_slots =
                (G.GAME.starting_params.consumable_slots or 2) - 1
            G.GAME.starting_params.discards =
                (G.GAME.starting_params.discards or 3) - 1
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.hand then
                    G.hand:change_size(-1)
                end
                ease_ante(-1)
                SMODS.change_play_limit(-0.5)
                SMODS.change_discard_limit(-0.5)
                return true
            end
        }))
    end
}
