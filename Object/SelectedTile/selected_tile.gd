extends Node3D

class_name SelectedTile

var location: Vector2i

func set_tile(x, y, width, height):
  location = Vector2i(x, y)
  position = Vector3(x + 0.5, 0, y + 0.5)
  position.y = Global.ON_Y / 2
  scale = Vector3(width, 1, height)
