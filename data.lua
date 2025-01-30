--data.lua
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
local planet_catalogue_vulcanus = require("__space-age__.prototypes.planet.procession-catalogue-vulcanus")

require("vicrox")

--START MAP GEN
function MapGen_Vicrox()
    local map_gen_setting = table.deepcopy(data.raw.planet.fulgora.map_gen_settings)
    map_gen_setting.property_expression_names =
    {
      elevation = "fulgora_elevation",
      temperature = "temperature_basic",
      moisture = "moisture_basic",
      aux = "aux_basic",
      cliffiness = "fulgora_cliffiness",
      cliff_elevation = "cliff_elevation_from_elevation",
    }
    
    map_gen_setting.autoplace_controls = {
        ["enemy-base"] = { frequency = 11, size = 1, richness = 1},
        ["fulgora_islands"] = {frequency = 1.75, size = 1.5, richness = 1.5},
        ["fulgora_cliff"] = {},
        ["trees"] = {},
        ["rocks"] = {},
        ["starting_area_moisture"] = {},
        ["nauvis_cliff"] = {}
    }
    
    map_gen_setting.cliff_settings ={
      name = "cliff-fulgora",
      control = "fulgora_cliff",
      cliff_elevation_0 = 80,
      -- Ideally the first cliff would be at elevation 0 on the coastline, but that doesn't work,
      -- so instead the coastline is moved to elevation 80.
      -- Also there needs to be a large cliff drop at the coast to avoid the janky cliff smoothing
      -- but it also fails if a corner goes below zero, so we need an extra buffer of 40.
      -- So the first cliff is at 80, and terrain near the cliff shouln't go close to 0 (usually above 40).
      cliff_elevation_interval = 40,
      cliff_smoothing = 0, -- This is critical for correct cliff placement on the coast.
      richness = 0.95
    }

    map_gen_setting.autoplace_settings["tile"] =
    {
        settings =
        {
          ["grass-1"] = {},
          ["grass-2"] = {},
          ["grass-3"] = {},
          ["grass-4"] = {},
          ["dry-dirt"] = {},
          ["dirt-1"] = {},
          ["dirt-2"] = {},
          ["dirt-3"] = {},
          ["dirt-4"] = {},
          ["dirt-5"] = {},
          ["dirt-6"] = {},
          ["dirt-7"] = {},
          ["sand-1"] = {},
          ["sand-2"] = {},
          ["sand-3"] = {},
          ["red-desert-0"] = {},
          ["red-desert-1"] = {},
          ["red-desert-2"] = {},
          ["red-desert-3"] = {},

          ["oil-ocean-shallow"] = {},
          ["oil-ocean-deep"] = {},
          --["fulgoran-rock"] = {},
          --["fulgoran-dust"] = {},
          --["fulgoran-sand"] = {},
          --["fulgoran-dunes"] = {},
          --["fulgoran-walls"] = {},
          --["fulgoran-paving"] = {},
          --["fulgoran-conduit"] = {},
          --["fulgoran-machinery"] = {},
        }
    }

    map_gen_setting.autoplace_settings["decorative"] =
    {
      settings =
      {
        ["brown-hairy-grass"] = {},
        ["green-hairy-grass"] = {},
        ["brown-carpet-grass"] = {},
        ["green-carpet-grass"] = {},
        ["green-small-grass"] = {},
        ["green-asterisk"] = {},
        ["brown-asterisk-mini"] = {},
        ["green-asterisk-mini"] = {},
        ["brown-asterisk"] = {},
        ["red-asterisk"] = {},
        ["dark-mud-decal"] = {},
        ["light-mud-decal"] = {},
        ["cracked-mud-decal"] = {},
        ["red-desert-decal"] = {},
        ["sand-decal"] = {},
        ["sand-dune-decal"] = {},
        ["green-pita"] = {},
        ["red-pita"] = {},
        ["green-croton"] = {},
        ["red-croton"] = {},
        ["green-pita-mini"] = {},
        ["brown-fluff"] = {},
        ["brown-fluff-dry"] = {},
        ["green-desert-bush"] = {},
        ["red-desert-bush"] = {},
        ["white-desert-bush"] = {},
        ["garballo-mini-dry"] = {},
        ["garballo"] = {},
        ["green-bush-mini"] = {},
        ["medium-rock"] = {},
        ["small-rock"] = {},
        ["tiny-rock"] = {},
        ["medium-sand-rock"] = {},
        ["small-sand-rock"] = {},

        ["fulgoran-ruin-tiny"] = {},
        ["fulgoran-gravewort"] = {},
        ["urchin-cactus"] = {},
        ["medium-fulgora-rock"] = {},
        ["small-fulgora-rock"] = {},
        ["tiny-fulgora-rock"] = {},
      }
    }

    map_gen_setting.autoplace_settings["entity"] =  { 
        settings = {
        ["vicrox-scrap"] = {},
        ["fulgoran-ruin-vault"] = { frequency = 2, size = 2, richness = 2},
        ["fulgoran-ruin-attractor"] = { frequency = 2, size = 2, richness = 2},
        ["fulgoran-ruin-colossal"] = { frequency = 2, size = 2, richness = 2},
        ["fulgoran-ruin-huge"] = { frequency = 2, size = 2, richness = 2},
        ["fulgoran-ruin-big"] = { frequency = 2, size = 2, richness = 2},
        ["fulgoran-ruin-stonehenge"] = { frequency = 2, size = 2, richness = 2},
        ["fulgoran-ruin-medium"] = { frequency = 2, size = 2, richness = 2},
        ["fulgoran-ruin-small"] = { frequency = 2, size = 2, richness = 2},
        ["fulgurite"] = {},
        ["big-fulgora-rock"] = {},
        ["big-sand-rock"] = {},
        ["huge-rock"] = {},
        ["big-rock"] = {},
        
        }
    }
     

    return map_gen_setting
end

--END MAP GEN

local nauvis = data.raw["planet"]["nauvis"]
local planet_lib = require("__PlanetsLib__.lib.planet")

local start_astroid_spawn_rate =
{
  probability_on_range_chunk =
  {
    {position = 0.1, probability = asteroid_util.nauvis_chunks, angle_when_stopped = asteroid_util.chunk_angle},
    {position = 0.9, probability = asteroid_util.nauvis_chunks, angle_when_stopped = asteroid_util.chunk_angle}
  },
  type_ratios =
  {
    {position = 0.1, ratios = asteroid_util.nauvis_ratio},
    {position = 0.9, ratios = asteroid_util.nauvis_ratio},
  }
}
local start_astroid_spawn = asteroid_util.spawn_definitions(start_astroid_spawn_rate, 0.1)


local vicrox = 
{
    type = "planet",
    name = "vicrox", 
    solar_power_in_space = 300,
    icon = "__planet-vicrox__/graphics/planet-vicrox.png",
    icon_size = 1024,
    label_orientation = 0.55,
    starmap_icon = "__planet-vicrox__/graphics/planet-vicrox.png",
    starmap_icon_size = 1024,
    order = "ce[vicrox]",
    magnitude = nauvis.magnitude,
    subgroup = "planets",
    platform_procession_set =
    {
      arrival = {"planet-to-platform-b"},
      departure = {"platform-to-planet-a"}
    },
    planet_procession_set =
    {
      arrival = {"platform-to-planet-b"},
      departure = {"planet-to-platform-a"}
    },
    procession_graphic_catalogue = planet_catalogue_vulcanus,
    surface_properties = {
        ["day-night-cycle"] = 12 * minute,
        ["magnetic-field"] = 99,
        ["solar-power"] = 70,
        pressure = nauvis.surface_properties["pressure"],
        gravity = 20
    },
    map_gen_settings = MapGen_Vicrox(),
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = start_astroid_spawn,
    pollutant_type = "pollution",
    persistent_ambient_sounds =
    {
      base_ambience = {filename = "__space-age__/sound/wind/base-wind-vulcanus.ogg", volume = 0.8},
      wind = {filename = "__space-age__/sound/wind/wind-vulcanus.ogg", volume = 0.8},
      crossfade =
      {
        order = {"wind", "base_ambience"},
        curve_type = "cosine",
        from = {control = 0.35, volume_percentage = 0.0},
        to = {control = 2, volume_percentage = 100.0}
      },
      semi_persistent =
      {
        {
          sound = {variations = sound_variations("__space-age__/sound/world/semi-persistent/distant-rumble", 3, 0.5)},
          delay_mean_seconds = 10,
          delay_variance_seconds = 5
        },
        {
          sound = {variations = sound_variations("__space-age__/sound/world/semi-persistent/distant-flames", 5, 0.6)},
          delay_mean_seconds = 15,
          delay_variance_seconds = 7.0
        }
      }
    },
    lightning_properties =
    {
      lightnings_per_chunk_per_tick = 1 / (60 * 10), --cca once per chunk every 10 seconds (600 ticks)
      search_radius = 10.0,
      lightning_types = {"lightning"},
      priority_rules =
      {
        {
          type = "id",
          string = "lightning-collector",
          priority_bonus = 10000
        },
        {
          type = "prototype",
          string = "lightning-attractor",
          priority_bonus = 1000
        },
        {
          type = "id",
          string = "fulgoran-ruin-vault",
          priority_bonus = 95
        },
        {
          type = "id",
          string = "fulgoran-ruin-colossal",
          priority_bonus = 94
        },
        {
          type = "id",
          string = "fulgoran-ruin-huge",
          priority_bonus = 93
        },
        {
          type = "id",
          string = "fulgoran-ruin-big",
          priority_bonus = 92
        },
        {
          type = "id",
          string = "fulgoran-ruin-medium",
          priority_bonus = 91
        },
        {
          type = "prototype",
          string = "pipe",
          priority_bonus = 1
        },
        {
          type = "prototype",
          string = "pump",
          priority_bonus = 1
        },
        {
          type = "prototype",
          string = "offshore-pump",
          priority_bonus = 1
        },
        {
          type = "prototype",
          string = "electric-pole",
          priority_bonus = 10
        },
        {
          type = "prototype",
          string = "power-switch",
          priority_bonus = 10
        },
        {
          type = "prototype",
          string = "logistic-robot",
          priority_bonus = 100
        },
        {
          type = "prototype",
          string = "construction-robot",
          priority_bonus = 100
        },
        {
          type = "impact-soundset",
          string = "metal",
          priority_bonus = 1
        }
      },
      exemption_rules =
      {
        {
          type = "prototype",
          string = "rail-support",
        },
        {
          type = "prototype",
          string = "legacy-straight-rail",
        },
        {
          type = "prototype",
          string = "legacy-curved-rail",
        },
        {
          type = "prototype",
          string = "straight-rail",
        },
        {
          type = "prototype",
          string = "curved-rail-a",
        },
        {
          type = "prototype",
          string = "curved-rail-b",
        },
        {
          type = "prototype",
          string = "half-diagonal-rail",
        },
        {
          type = "prototype",
          string = "rail-ramp",
        },
        {
          type = "prototype",
          string = "elevated-straight-rail",
        },
        {
          type = "prototype",
          string = "elevated-curved-rail-a",
        },
        {
          type = "prototype",
          string = "elevated-curved-rail-b",
        },
        {
          type = "prototype",
          string = "elevated-half-diagonal-rail",
        },
        {
          type = "prototype",
          string = "rail-signal",
        },
        {
          type = "prototype",
          string = "rail-chain-signal",
        },
        {
          type = "prototype",
          string = "locomotive",
        },
        {
          type = "prototype",
          string = "artillery-wagon",
        },
        {
          type = "prototype",
          string = "cargo-wagon",
        },
        {
          type = "prototype",
          string = "fluid-wagon",
        },
        {
          type = "prototype",
          string = "land-mine",
        },
        {
          type = "prototype",
          string = "wall",
        },
        {
          type = "prototype",
          string = "tree",
        },
        {
          type = "countAsRockForFilteredDeconstruction",
          string = "true",
        },
      }
    }
}

vicrox.orbit = {
    parent = {
        type = "space-location",
        name = "star",
    },
    distance = 23,
    orientation = 0.24
}

local vicrox_connection = {
    type = "space-connection",
    name = "vulcanus-vicrox",
    from = "nauvis",
    to = "vicrox",
    subgroup = data.raw["space-connection"]["nauvis-vulcanus"].subgroup,
    length = 15000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus),
}
data:extend{vicrox_connection}

PlanetsLib:extend({vicrox})

PlanetsLib.borrow_music(data.raw["planet"]["fulgora"], vicrox)

data:extend {{
    type = "technology",
    name = "planet-discovery-vicrox",
    icons = PlanetsLib.technology_icon_constant_planet("__planet-vicrox__/graphics/planet-vicrox.png", 1024),
    icon_size = 1024,
    essential = true,
    localised_description = {"space-location-description.vicrox"},
    effects = {
        {
            type = "unlock-space-location",
            space_location = "vicrox",
            use_icon_overlay_constant = true
        },
        {
            type = "unlock-recipe",
            recipe = "lightning-rod",
        },
        {
            type = "unlock-recipe",
            recipe = "vicrox-scrap-recycling",
        },
    },
    prerequisites = {
        "space-science-pack",
    },
    unit = {
        count = 200,
        ingredients = {
            {"automation-science-pack",      1},
            {"logistic-science-pack",        1},
            {"chemical-science-pack",        1},
            {"space-science-pack",           1}
        },
        time = 60,
    },
    order = "ea[vicrox]",
}}


APS.add_planet{name = "vicrox", filename = "__planet-vicrox__/vicrox.lua", technology = "planet-discovery-vicrox"}