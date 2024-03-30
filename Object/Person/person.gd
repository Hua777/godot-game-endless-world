extends CharacterBody3D

class_name Person

const ArrowTscn: PackedScene = preload ("res://Object/Arrow/arrow.tscn")

@onready var SELECTED_MESH: MeshInstance3D = $SelectedMesh

var person_id: int = -1

var castle_location: Vector2i = Vector2i( - 1, -1)
var origin_location: Vector2i = Vector2i( - 1, -1)
var target_location: Vector2i = Vector2i( - 1, -1)
var speed = 1

var arrow: Arrow = ArrowTscn.instantiate()

func set_tile(db_tile: Dictionary) -> void:
  origin_location = Vector2i(db_tile.x, db_tile.y)
  position = Vector3(db_tile.x, 0, db_tile.y)
  position.y = Global.ON_Y

func move_to_tile(db_tile: Dictionary) -> void:
  target_location = Vector2i(db_tile.x, db_tile.y)
  arrow.set_from_and_to(
    Vector3(origin_location.x + 0.5, Global.ON_Y, origin_location.y + 0.5),
    Vector3(target_location.x + 0.5, Global.ON_Y, target_location.y + 0.5)
  )
  arrow.visible = true

func selected() -> void:
  SELECTED_MESH.visible = true

func unselect() -> void:
  SELECTED_MESH.visible = false

func _ready():
  SELECTED_MESH.visible = false
  get_parent().add_child(arrow)
  arrow.visible = false

func _physics_process(delta):
  if target_location.x >= 0 and target_location.y >= 0:
    var target = Vector3(target_location.x + 0.5, Global.ON_Y, target_location.y + 0.5)
    var d = target.distance_to(position)
    if d > 0.01:
      look_at(target)
      var dir = global_position.direction_to(target)
      velocity = dir * speed
      move_and_slide()
    else:
      emit_signal('event_somebody_arrived_tile', self, target_location)
      arrow.visible = false
      origin_location = target_location
      target_location = Vector2i( - 1, -1)
