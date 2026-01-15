SMODS.Atlas({
    key = "modicon",
    path = "ModIcon.png",
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "Copy_Jokers",
    path = "Copy_Jokers.png",
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
})

local NFS = require("nativefs")
local function load_jokers_folder()
    local jokers_path = SMODS.current_mod.path .. "/jokers"
    local ok, files = pcall(NFS.getDirectoryItemsInfo, jokers_path)
    for _, file in ipairs(files) do
        if file.name:sub(-4) == ".lua" then
            local success, err = pcall(function()
                assert(SMODS.load_file("jokers/" .. file.name))()
            end)
        end
    end
end

load_jokers_folder()

SMODS.current_mod.optional_features = function()
    return {
        cardareas = {}
    }
end
