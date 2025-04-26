local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")

data:extend({
  {
    type = "item",
    name = "cupric-asteroid-chunk",
    icon = "__cupric-asteroids__/graphics/icons/cupric-asteroid-chunk.png",
    subgroup = "space-material",
    order = "cb[cupric]-e[chunk]",
    inventory_move_sound = space_age_item_sounds.rock_inventory_move,
    pick_sound = space_age_item_sounds.rock_inventory_pickup,
    drop_sound = space_age_item_sounds.rock_inventory_move,
    stack_size = 1,
    weight = 100 * kg
  },
})

if settings.startup["cupric-asteroids-military"].value then
  data:extend({
    {
      type = "ammo",
      name = "smart-rounds-magazine",
      icon = "__cupric-asteroids__/graphics/icons/smart-rounds-magazine.png",
      ammo_category = "bullet",
      ammo_type = {
        cooldown_modifier = 10/9,
        action = {
          type = "direct",
          action_delivery = {
            type = "instant",
            source_effects = {
              type = "create-explosion",
              entity_name = "explosion-gunshot"
            },
            target_effects = {
              {
                type = "create-entity",
                entity_name = "explosion-hit",
                offsets = {{0, 1}},
                offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
              },
              {type="damage", damage={amount=10, type="physical"}},
              {type="activate-impact", deliver_category="bullet"}
            }
          }
        }
      },
      magazine_size = 10,
      subgroup = "ammo",
      order = "a[basic-clips]-b[smart-rounds-magazine]",
      inventory_move_sound = item_sounds.ammo_small_inventory_move,
      pick_sound = item_sounds.ammo_small_inventory_pickup,
      drop_sound = item_sounds.ammo_small_inventory_move,
      stack_size = 100,
      weight = 20*kg
    },
  })
end

-------------------------------------------------------------------------- Settings proxy items

local function create_proxy_item(name, icon)
  return {
    type = "item",
    name = name,
    icon = icon,
    hidden = true,
    stack_size = 1
  }
end

data:extend({
  create_proxy_item("wcu-proxy-smart-rounds", "__cupric-asteroids__/graphics/icons/smart-rounds-magazine.png")
})
