class_name LegionBase

var name: String = '无'

var leaders: Array[Attackable] = []

var arms: Array[Attackable] = []

func still_alive() -> bool:
  for leader in leaders:
    if leader.still_alive():
      return true
  for arm in arms:
    if arm.still_alive():
      return true
  return false

func _to_string() -> String:
  return 'name = %s' % [name]
