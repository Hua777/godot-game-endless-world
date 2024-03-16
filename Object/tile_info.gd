class_name TileInfo

const TILE_DEFAULT_SIZE = Vector2(1, 1)

const ITEM_GRESS = 0
const ITEM_SOIL = 1
const ITEM_WATER = 2
const ITEM_CASTLE = 3
const TILE_SIZE_MAP = {
  ITEM_CASTLE: Vector2(3, 3),
}

var location: Vector2i
var item: int
var orientation: int
var your: bool

static func create(
  _location: Vector2i,
  _item: int,
  _orientation: int,
  _your: bool,
  ) -> TileInfo:
  var info = TileInfo.new()
  info.location = _location
  info.item = _item
  info.orientation = _orientation
  info.your = _your
  return info

func get_tile_size() -> Vector2:
  if item in TILE_SIZE_MAP:
    return TILE_SIZE_MAP[item]
  return TILE_DEFAULT_SIZE

func get_tile_location_3d() -> Vector3i:
  return Vector3(location.x, 0, location.y)

func get_tile_position_3d() -> Vector3:
  return Vector3(location.x + 0.5, 0, location.y + 0.5)
