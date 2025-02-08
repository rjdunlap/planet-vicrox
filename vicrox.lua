local utils = require("__any-planet-start__.utils")

utils.set_trigger("oil-processing", {type = "build-entity", entity = "offshore-pump"})
utils.set_prerequisites("battery", {"recycling"})
utils.set_trigger("battery", {type = "craft-item", item = "battery", count = 5})
utils.add_recipes("battery", {"accumulator"})
