extends Node3D

class_name OwnerTile

@onready var GREEN_PLANE = $GreenPlane
@onready var RED_PLANE = $RedPlane

func set_tile(tile: TileInfo):
  position = tile.get_tile_position_3d()
  position.y = Global.ON_Y + 0.01
  scale = Vector3(tile.detail.size.x, 1, tile.detail.size.y)
  if tile.your:
    GREEN_PLANE.visible = true
    RED_PLANE.visible = false
  else:
    GREEN_PLANE.visible = false
    RED_PLANE.visible = true

func _ready() -> void:
  pass

func _process(delta: float) -> void:
  pass
