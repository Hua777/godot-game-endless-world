extends Node

@onready var CAMERA: Camera3D = $Camera3D
@onready var DYNAMIC_WORLD: Node3D = $DynamicWorld

const MOVE_CAMERA_DENSE = 0.01

var mouse_mode = 'none'

func _ready():
  pass

func _input(event):
  if event is InputEventMouseButton:
    if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == false:
      # 左键起来
      if mouse_mode == 'mouse_left':
        var mouse_position = get_viewport().get_mouse_position()
        var from = CAMERA.project_ray_origin(mouse_position)
        var direct = CAMERA.project_ray_normal(mouse_position) * CAMERA.far
        DYNAMIC_WORLD.try_click(from, direct)
      mouse_mode = 'none'
    if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
      # 左键下去
      mouse_mode = 'mouse_left'
  elif event is InputEventMouseMotion:
    if mouse_mode == 'mouse_left' or mouse_mode == 'mouse_left_move':
      # 左键按住移动
      mouse_mode = 'mouse_left_move'
      var direct = Vector3(event.relative.y * MOVE_CAMERA_DENSE, 0, -event.relative.x * MOVE_CAMERA_DENSE)
      CAMERA.position = CAMERA.position + direct.rotated(Vector3(0, 1, 0), deg_to_rad(-45))

func _process(delta):
  pass
