local utils = require("__any-planet-start__.utils")
local resource_autoplace = require("resource-autoplace")
local sounds = require("__base__.prototypes.entity.sounds")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")
local item_sounds = require("__base__.prototypes.item_sounds")

utils.set_prerequisites("recycling", nil)
utils.remove_tech("uranium-processing", true, true)

local merge = require("lib").merge

-- Custom Scrap

data:extend({
	merge(data.raw.resource["scrap"], {
		name = "vicrox-scrap",
		icon_size = 64,
		order = "w-a[vicrox-scrap]",
		minable = merge(data.raw.resource["scrap"].minable, {
			mining_time = 0.33,
			result = "vicrox-scrap",
		}),
		map_color = { 0.18, 0.22, 0.2 },
		map_grid = true,
		factoriopedia_simulation = "nil",
	}),})

data:extend{{
    type = "item",
    name = "vicrox-scrap",
    icon = "__space-age__/graphics/icons/scrap.png",
    pictures =
    {
      { size = 64, filename = "__space-age__/graphics/icons/scrap.png",   scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__space-age__/graphics/icons/scrap-1.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__space-age__/graphics/icons/scrap-2.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__space-age__/graphics/icons/scrap-3.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__space-age__/graphics/icons/scrap-4.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__space-age__/graphics/icons/scrap-5.png", scale = 0.5, mipmap_count = 4 }
    },
    subgroup = "fulgora-processes",
    order = "a[vicrox-scrap]-a[vicrox-scrap]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 50,
    default_import_location = "vicrox",
    weight = 2*kg
  }
}

data:extend{
{
    type = "recipe",
    name = "vicrox-scrap-recycling",
    icons = {
      {
        icon = "__quality__/graphics/icons/recycling.png"
      },
      {
        icon = "__space-age__/graphics/icons/scrap.png",
        scale = 0.4
      },
      {
        icon = "__quality__/graphics/icons/recycling-top.png"
      }
    },
    category = "recycling-or-hand-crafting",
    subgroup = "fulgora-processes",
    order = "a[trash]-a[trash-recycling]",
    enabled = false,
    auto_recycle = false,
    energy_required = 0.4,
    ingredients = {{type = "item", name = "vicrox-scrap", amount = 1}},
    results =
    {
      {type = "item", name = "ice",                    amount = 1, probability = 0.25, show_details_in_recipe_tooltip = false},
      {type = "item", name = "iron-ore",               amount = 1, probability = 0.225, show_details_in_recipe_tooltip = false},
      {type = "item", name = "scrap",                  amount = 1, probability = 0.10, show_details_in_recipe_tooltip = false},
      {type = "item", name = "copper-ore",             amount = 1, probability = 0.075, show_details_in_recipe_tooltip = false},
      {type = "item", name = "coal",                   amount = 1, probability = 0.05, show_details_in_recipe_tooltip = false},
      {type = "item", name = "stone",                  amount = 1, probability = 0.03, show_details_in_recipe_tooltip = false},
      {type = "item", name = "stone-brick",            amount = 1, probability = 0.03, show_details_in_recipe_tooltip = false},
      {type = "item", name = "wooden-chest",           amount = 1, probability = 0.025, show_details_in_recipe_tooltip = false},
      {type = "item", name = "uranium-ore",            amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false},
      {type = "item", name = "raw-fish",               amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false},
    }
  }
}

