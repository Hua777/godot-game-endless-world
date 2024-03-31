extends GridMap

func _ready() -> void:

  # 初始化数据库

  DatabaseInstance.init_db()
  BackendInstance.init_base_data()

  # 初始化玩家

  BackendInstance.save_player(Global.PLAYER_YOU, '你')
  BackendInstance.save_player(Global.PLAYER_SYSTEM, '系统')
  BackendInstance.save_player(Global.PLAYER_ANT, '蚂蚁人')

  # 初始化第一关数据

  BackendInstance.save_base_level(1)

  # 初始化地块

  for location in get_used_cells():
    var item = get_cell_item(location)
    var orientation = get_cell_item_orientation(location)
    if location.y == 0:
      # 自然环境
      BackendInstance.save_base_level_tile(1, location.x, location.z, item, orientation)
    elif location.y == 1:
      # 我方地块
      BackendInstance.save_base_level_tile_build(1, location.x, location.z, item, orientation, Global.PLAYER_YOU)
    elif location.y == 2:
      # 敌方地块
      BackendInstance.save_base_level_tile_build(1, location.x, location.z, item, orientation, Global.PLAYER_ANT)

  # 初始化系统守军

  var normal_legion_id = BackendInstance.random_player_legion(Global.PLAYER_SYSTEM, '守军', Global.CLASSIFY_HUMAN, Global.RARITY_1)

  for db_tile in BackendInstance.load_base_level_tile(1):
    var db_tile_extend = BackendInstance.get_base_tile(db_tile.tile_id)
    if db_tile_extend.moveable:
      BackendInstance.save_player_level_tile_legion(1, db_tile.x, db_tile.y, Global.TILE_LEGION_TYPE_FIXED, normal_legion_id)

  # 关闭数据库

  DatabaseInstance.close_db()

func _process(delta: float) -> void:
  pass
