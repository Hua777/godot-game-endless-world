extends MeshInstance3D

class_name SelectedTile

func set_tile(tile: TileInfo) -> void:
  position = tile.get_tile_position_3d()
  position.y = 0.31 / 2
  scale = Vector3(tile.get_tile_size().x, 1, tile.get_tile_size().y)

func _ready() -> void:
  pass

func _process(delta: float) -> void:
  pass
