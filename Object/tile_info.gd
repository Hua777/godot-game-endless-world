class_name TileInfo

var location: Vector2i
var item: int
var orientation: int
var your: bool
var detail: Tile

func _init(
  _location: Vector2i,
  _item: int,
  _orientation: int,
  _your: bool,
  ):
  location = _location
  item = _item
  orientation = _orientation
  your = _your
  detail = Global.TILE_ITEM_MAP[item]

func get_tile_location_3d() -> Vector3i:
  return Vector3(location.x, 0, location.y)

func get_tile_position_3d() -> Vector3:
  return Vector3(location.x + 0.5, 0, location.y + 0.5)

func get_neighbor_locations():
  var result = []
  var size = detail.size
  var rx = int(size.x / 2)
  var ry = int(size.y / 2)
  for i in range(location.x - rx - 1, location.x + rx + 2):
    for j in range(location.y - ry - 1, location.y + ry + 2):
      if (i < location.x - rx or i > location.x + rx) or (j < location.y - ry or j > location.y + ry):
        result.append(Vector2i(i, j))
  return result
