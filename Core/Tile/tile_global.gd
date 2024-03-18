class_name TileGlobal

var ON_Y = 0.3
var M_PER_TILE = 1

var TILE_GRASS_LV1: TileConst = TileConst.new(
  0, 0, 0, 0, 0, 0, 1, true, 1, 1
)
var TILE_SOIL_LV1: TileConst = TileConst.new(
  1, 0, 0, 0, 0, 0, 1, true, 1, 1
)
var TILE_WATER_LV1: TileConst = TileConst.new(
  2, 0, 0, 0, 0, 0, 1, false, 1, 1
)
var TILE_WOOD_LV1: TileConst = TileConst.new(
  3, 0, 1, 0, 0, 0, 1, true, 1, 1
)
var TILE_STONE_LV1: TileConst = TileConst.new(
  4, 0, 0, 1, 0, 0, 1, true, 1, 1
)
var TILE_FOOD_LV1: TileConst = TileConst.new(
  5, 1, 0, 0, 0, 0, 1, true, 1, 1
)
var TILE_MAIN_CASTLE_LV1: TileConst = TileConst.new(
  6, 0, 0, 0, 0, 0, 1, true, 3, 3
)

var TILE_ITEM_MAP = {
  TILE_GRASS_LV1.item: TILE_GRASS_LV1,
  TILE_SOIL_LV1.item: TILE_SOIL_LV1,
  TILE_WATER_LV1.item: TILE_WATER_LV1,
  TILE_WOOD_LV1.item: TILE_WOOD_LV1,
  TILE_STONE_LV1.item: TILE_STONE_LV1,
  TILE_FOOD_LV1.item: TILE_FOOD_LV1,
  TILE_MAIN_CASTLE_LV1.item: TILE_MAIN_CASTLE_LV1,
}
