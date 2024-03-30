extends GridMap

func _ready() -> void:

  DatabaseInstance.init_db()
  BackendInstance.init_base_data()

  BackendInstance.save_base_level(1)
  for location in get_used_cells():
    var item = get_cell_item(location)
    var orientation = get_cell_item_orientation(location)
    if location.y == 0:
      BackendInstance.save_base_level_tile(1, location.x, location.z, item, orientation)
    elif location.y == 1:
      BackendInstance.save_base_level_tile_build(1, location.x, location.z, item, orientation, Global.PLAYER_YOU)
    elif location.y == 2:
      BackendInstance.save_base_level_tile_build(1, location.x, location.z, item, orientation, Global.PLAYER_ANT)

  BackendInstance.save_player(Global.PLAYER_YOU, '你')
  BackendInstance.save_player(Global.PLAYER_ANT, '蚂蚁人')

  DatabaseInstance.close_db()

func _process(delta: float) -> void:
  pass
