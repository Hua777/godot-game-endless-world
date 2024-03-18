class_name TileStone

extends TileWithLevel

func _init(_level: int):
  var g = -1
  if _level == 1:
    g = 4
  super(
    g,
    1, 1,
    _level,
    '石头',
  )
  stone_per_second = _level