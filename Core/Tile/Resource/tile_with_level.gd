class_name TileWithLevel

extends TileBase

func _init(
  _grid_map_item_id: int,
  _width: int, _height: int,
  _level: int,
  _name: String
):
  grid_map_item_id = _grid_map_item_id
  width = _width
  height = _height
  level = _level
  moveable = true
  name = _name