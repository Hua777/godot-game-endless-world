class_name TileGlobal

var ON_Y = 0.3
var M_PER_TILE = 1

var TILE_GRASS_LV1: TileBase = TileGrass.new()
var TILE_SOIL_LV1: TileBase = TileSoil.new()
var TILE_WATER_LV1: TileBase = TileWater.new()
var TILE_WOOD_LV1: TileBase = TileWood.new(1)
var TILE_STONE_LV1: TileBase = TileStone.new(1)
var TILE_FOOD_LV1: TileBase = TileFood.new(1)
var TILE_MAIN_CASTLE_LV1: TileBase = TileMainCastle.new(1)

var TILE_ITEM_MAP = {
  TILE_GRASS_LV1.detail.grid_map_item_id: TILE_GRASS_LV1,
  TILE_SOIL_LV1.detail.grid_map_item_id: TILE_SOIL_LV1,
  TILE_WATER_LV1.detail.grid_map_item_id: TILE_WATER_LV1,
  TILE_WOOD_LV1.detail.grid_map_item_id: TILE_WOOD_LV1,
  TILE_STONE_LV1.detail.grid_map_item_id: TILE_STONE_LV1,
  TILE_FOOD_LV1.detail.grid_map_item_id: TILE_FOOD_LV1,
  TILE_MAIN_CASTLE_LV1.detail.grid_map_item_id: TILE_MAIN_CASTLE_LV1,
}
