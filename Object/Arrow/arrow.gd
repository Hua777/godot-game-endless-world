extends Node3D

class_name Arrow

@onready var HEAD: MeshInstance3D = $Head
@onready var BODY: MeshInstance3D = $Body

func set_from_and_to(from: Vector3, to: Vector3) -> void:
  var center = (from + to) / 2.0
  position = center
  var d = to.distance_to(from)
  BODY.mesh.height = max(d, 0.05)
  HEAD.position = Vector3(0, 0, -d / 2)
  look_at(to)

func _ready() -> void:
  pass

func _process(delta: float) -> void:
  pass
