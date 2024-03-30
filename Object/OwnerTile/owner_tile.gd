extends Node3D

class_name OwnerTile

@onready var GREEN_PLANE = $GreenPlane
@onready var RED_PLANE = $RedPlane

func set_tile(x, y, width, height, color_flag):
  position = Vector3(x + 0.5, 0, y + 0.5)
  position.y = Global.ON_Y + 0.01
  scale = Vector3(width, 1, height)
  if color_flag == Global.COLOR_FLAG_GREEN:
    GREEN_PLANE.visible = true
    RED_PLANE.visible = false
  else:
    GREEN_PLANE.visible = false
    RED_PLANE.visible = true
