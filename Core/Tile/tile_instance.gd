class_name TileInstance

# 地标
var location: Vector2i

# 详细信息
var detail: TileBase

# 转向
var grid_map_orientation: int

# 拥有者
var owner: int = -1

func _init(
  _location: Vector2i,
  _grid_map_item_id: int,
  _grid_map_orientation: int,
):
  location = _location
  detail = Global.TILE_ITEM_MAP[_grid_map_item_id]
  grid_map_orientation = _grid_map_orientation

# 获取 3 维地标
func get_location_3d() -> Vector3i:
  return Vector3(location.x, 0, location.y)

# 获取 3 维位置
func get_position_3d() -> Vector3:
  return Vector3(location.x * (Global.M_PER_TILE + 0.5), 0, location.y * (Global.M_PER_TILE + 0.5))

# 获取相邻几个坐标
func get_neighbor_locations() -> Array[Vector2i]:
  var result: Array[Vector2i] = []
  var rx = int(detail.width / 2)
  var ry = int(detail.height / 2)
  for i in range(location.x - rx - 1, location.x + rx + 2):
    for j in range(location.y - ry - 1, location.y + ry + 2):
      if (i < location.x - rx or i > location.x + rx) or (j < location.y - ry or j > location.y + ry):
        result.append(Vector2i(i, j))
  return result
