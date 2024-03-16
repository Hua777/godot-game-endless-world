class_name Tile

var item: int
var size: Vector2
var level: int
var moveable: bool

func _init(_item, _size, _level, _moveable):
  item = _item
  size = _size
  level = _level
  moveable = _moveable
