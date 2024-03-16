extends CharacterBody3D

class_name Person

var person_id: int = -1

var castle_location: Vector2i = Vector2i( - 1, -1)
var origin_location: Vector2i = Vector2i( - 1, -1)
var target_location: Vector2i = Vector2i( - 1, -1)
var speed = 0.5

const on_y = 0.3

func set_tile(tile: TileInfo) -> void:
  position = tile.get_tile_position_3d()
  position.y = on_y

func move_to_tile(tile: TileInfo) -> void:
  target_location = tile.location

func _ready():
  pass

func _physics_process(delta):
  if target_location.x >= 0 and target_location.y >= 0:
    var target = Vector3(target_location.x + 0.5, on_y, target_location.y + 0.5)
    var d = target.distance_squared_to(position)
    if d > 0.01:
      look_at(target)
      var dir = global_position.direction_to(target)
      velocity = dir * speed
      move_and_slide()
    else:
      target_location = Vector2i( - 1, -1)
