extends Node3D

class_name SelectedTile

func set_tile(tile: TileInfo) -> void:
  position = tile.get_tile_position_3d()
  position.y = Global.ON_Y / 2
  scale = Vector3(tile.detail.size.x, 1, tile.detail.size.y)

func _ready() -> void:
  pass

func _process(delta: float) -> void:
  pass
