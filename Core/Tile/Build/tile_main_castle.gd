class_name TileMainCastle

extends TileWithLevel

func _init(_level: int):
  var g = -1
  if _level == 1:
    g = 6
  super(
    g,
    1, 1,
    _level,
    '主城堡',
  )
  food_per_second = _level
  stone_per_second = _level
  wood_per_second = _level
  gold_per_second = _level / 2.0
