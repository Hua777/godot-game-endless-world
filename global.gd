extends Node

var ON_Y = 0.3

var TILE_GRASS_LV1: Tile = Tile.new(0, Vector2(1, 1), 1, true)
var TILE_SOIL_LV1: Tile = Tile.new(1, Vector2(1, 1), 1, true)
var TILE_WATER_LV1: Tile = Tile.new(2, Vector2(1, 1), 1, false)
var TILE_WOOD_LV1: Tile = Tile.new(3, Vector2(1, 1), 1, true)
var TILE_STONE_LV1: Tile = Tile.new(4, Vector2(1, 1), 1, true)
var TILE_FOOD_LV1: Tile = Tile.new(5, Vector2(1, 1), 1, true)
var TILE_CASTLE_LV1: Tile = Tile.new(6, Vector2(3, 3), 1, true)

var TILE_ITEM_MAP = {
    TILE_GRASS_LV1.item: TILE_GRASS_LV1,
    TILE_SOIL_LV1.item: TILE_SOIL_LV1,
    TILE_WATER_LV1.item: TILE_WATER_LV1,
    TILE_WOOD_LV1.item: TILE_WOOD_LV1,
    TILE_STONE_LV1.item: TILE_STONE_LV1,
    TILE_FOOD_LV1.item: TILE_FOOD_LV1,
    TILE_CASTLE_LV1.item: TILE_CASTLE_LV1,
}
