class_name TileWood

extends TileWithLevel

func _init(_level: int):
  var g = -1
  if _level == 1:
    g = 3
  super(
    g,
    1, 1,
    _level,
    '木头',
  )
  wood_per_second = _level