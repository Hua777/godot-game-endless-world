class_name TileFood

extends TileWithLevel

func _init(_level: int):
  var g = -1
  if _level == 1:
    g = 5
  super(
    g,
    1, 1,
    _level,
    '食物',
  )
  food_per_second = _level