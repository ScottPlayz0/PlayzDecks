SMODS.Atlas({
    key = "modicon",
    path = "ModIcon.png",
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "shattered_deck",
    path = "shattered_deck.png",
    px = 71,
    py = 95
})

SMODS.Back{
    key = 'shattered_deck',
    pos = { x = 0, y = 0 },
    atlas = 'shattered_deck',
    config = {
        extra = {
            hand_size0 = 1,
            hand_size = 1
        }
    },
    loc_txt = {
        name = 'Shattered Deck',
        text = {
            [1] = '{C:red}-2{} Joker and Consumable Slots',
            [2] = '{C:red}-1{} Hand Size, Hands, and Discards',
            [3] = '{C:attention}+1{} In any lost stat after',
            [4] = '{C:attention}Defeating the Boss Blind{}'
        }
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    calculate = function(self, back, context)
        if context.context == "eval" and G.GAME.last_blind and G.GAME.last_blind.boss then
            if G.jokers and G.jokers.config then
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            end
            if G.consumeables and G.consumeables.config then
                G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
            end
            if G.GAME and G.GAME.starting_params then
                G.GAME.starting_params.joker_slots = (G.GAME.starting_params.joker_slots or 3) + 1
                G.GAME.starting_params.consumable_slots = (G.GAME.starting_params.consumable_slots or 0) + 1
            end
            if G.hand then
                G.hand:change_size(1)
            end
            if G.GAME then
                G.GAME.round_resets.hands = (G.GAME.round_resets.hands or 0) + 1
                ease_hands_played(1)
            end
            if G.GAME then
                G.GAME.round_resets.discards = (G.GAME.round_resets.discards or 0) + 1
                ease_discard(1)
            end
        end
    end,

    apply = function(self, back)
        if G.GAME.starting_params then
            G.GAME.starting_params.hands = (G.GAME.starting_params.hands or 4) - 1
            G.GAME.starting_params.joker_slots = (G.GAME.starting_params.joker_slots or 5) - 2
            G.GAME.starting_params.consumable_slots = (G.GAME.starting_params.consumable_slots or 2) - 2
            G.GAME.starting_params.discards = (G.GAME.starting_params.discards or 3) - 1
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.hand then
                    G.hand:change_size(-1)
                end
                return true
            end
        }))
        return {}
    end
}
