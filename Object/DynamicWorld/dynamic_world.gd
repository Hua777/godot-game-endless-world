extends Node3D

@onready var BASE_GRID_MAP: GridMap = $BaseGridMap

const 游戏等级 = 1

const SelectedTileTscn: PackedScene = preload ("res://Object/SelectedTile/selected_tile.tscn")
const PersonTscn: PackedScene = preload ("res://Object/Person/person.tscn")
const OwnerTileTscn: PackedScene = preload ("res://Object/OwnerTile/owner_tile.tscn")

var 你选取的地块: SelectedTile = null

var 土地所有权标识字典 = {}

# func refresh_owner_in_grid(tile: TileInfo) -> void:
#   if tile.location not in OWNER_MAP:
#     var owner = OwnerTileTscn.instantiate()
#     OWNER_MAP[tile.location] = owner
#     add_child(owner)
#     owner.set_tile(tile)
#   else:
#     OWNER_MAP[tile.location].set_tile(tile)

# func remove_owner_from_grid(tile: TileInfo) -> void:
#   if tile.location in OWNER_MAP:
#     remove_child(OWNER_MAP[tile.location])
#     OWNER_MAP.erase(tile.location)

func 刷新土地所有权(x, y):
  var location = Vector2i(x, y)
  var db_player_tile = BackendInstance.get_tile_in_player_level(游戏等级, x,y)
  if db_player_tile == null:
    if location in 土地所有权标识字典:
      remove_child(土地所有权标识字典[location])
      土地所有权标识字典.erase(location)
  else:
    var db_tile_extend = BackendInstance.get_base_tile(db_player_tile.tile_id)
    if location not in 土地所有权标识字典:
      var owner = OwnerTileTscn.instantiate()
      土地所有权标识字典[location] = owner
      add_child(owner)
      owner.set_tile(x, y, db_tile_extend.width, db_tile_extend.height,
        Global.COLOR_FLAG_GREEN if db_player_tile.player_id == Global.PLAYER_YOU else Global.COLOR_FLAG_RED)
    else:
      土地所有权标识字典[location].set_tile(x, y, db_tile_extend.width, db_tile_extend.height,
        Global.COLOR_FLAG_GREEN if db_player_tile.player_id == Global.PLAYER_YOU else Global.COLOR_FLAG_RED)


func 移除地块(db_tile: Dictionary):
  BASE_GRID_MAP.set_cell_item(Vector3i(db_tile.x, 0, db_tile.y), -1, 0)
  var db_tile_extend = BackendInstance.get_base_tile(db_tile.tile_id)
  var rx = int(db_tile_extend.width / 2)
  var ry = int(db_tile_extend.height / 2)
  for i in range(db_tile.x - rx, db_tile.x + rx + 1):
    for j in range(db_tile.y - ry, db_tile.y + ry + 1):
      var base_tile = BackendInstance.get_tile_in_base_level(游戏等级, i, j)
      BASE_GRID_MAP.set_cell_item(Vector3i(base_tile.x, 0, base_tile.y), base_tile.tile_id, base_tile.orientation)

func 添加人为地块(db_tile: Dictionary):
  var db_tile_extend = BackendInstance.get_base_tile(db_tile.tile_id)
  var rx = int(db_tile_extend.width / 2)
  var ry = int(db_tile_extend.height / 2)
  for i in range(db_tile.x - rx, db_tile.x + rx + 1):
    for j in range(db_tile.y - ry, db_tile.y + ry + 1):
      if BASE_GRID_MAP.get_cell_item(Vector3i(i, 0, j)) >= 0:
        BASE_GRID_MAP.set_cell_item(Vector3i(i, 0, j), -1, 0)
  BASE_GRID_MAP.set_cell_item(Vector3i(db_tile.x, 0, db_tile.y), db_tile.tile_id, db_tile.orientation)

func 占领地块(player_id: int, x: int, y: int):
  var finished = false

  var db_player_tile = BackendInstance.get_tile_in_player_level(游戏等级, x, y)

  if db_player_tile != null:
    if db_player_tile.player_id != player_id:
      # 敌人城堡攻破
      var db_tile = BackendInstance.get_base_tile(db_player_tile.tile_id)
      if db_tile.type == Global.TILE_TYPE_BUILD:
        BackendInstance.remove_player_level_tile_build(游戏等级, x, y)
        finished = true
    else:
      finished = true

  # 自然资源占领
  if not finished:
    var db_tile = BackendInstance.get_tile_in_base_level(游戏等级, x, y)
    var db_tile_extend = BackendInstance.get_base_tile(db_tile.tile_id)
    if db_tile_extend.moveable:
      BackendInstance.save_player_level_tile_build(游戏等级, x, y, db_tile.tile_id, db_tile.orientation, player_id)
    finished = true

  刷新土地所有权(x, y)

func 初始化自然地块():
  for db_tile in BackendInstance.load_base_level_tile(游戏等级):
    BASE_GRID_MAP.set_cell_item(Vector3i(db_tile.x, 0, db_tile.y), db_tile.tile_id, db_tile.orientation)

func 初始化人为地块():
  BackendInstance.init_player_level_tile_build(游戏等级)
  for db_tile in BackendInstance.load_player_level_tile(游戏等级):
    添加人为地块(db_tile)
    刷新土地所有权(db_tile.x, db_tile.y)

#func init_person():
  #var person: Person = PersonTscn.instantiate()
  #person.person_id = 1
  #person.origin_location = Vector2i(1, 1)
  #person.set_tile(COVER_MAP[Vector2i(1, 1)])
  #person.connect('event_somebody_arrived_tile', Callable(self, 'person_arrived_tile'))
  #PERSON_MAP[person.person_id] = person
  #add_child(person)
#
#func move_person_to_tile(person_id: int, tile: TileInfo):
  #if not tile.detail.moveable:
    #return
  #var ok = false
  #for v in tile.get_neighbor_locations():
    #if v in NATURE_MAP and NATURE_MAP[v].your:
      #ok = true
      #break
    #if v in COVER_MAP and COVER_MAP[v].your:
      #ok = true
      #break
  #if ok:
    #var person = PERSON_MAP[person_id]
    #person.move_to_tile(tile)

func _ready():
  初始化自然地块()
  初始化人为地块()

func cancel_selected():
  if 你选取的地块 != null:
    remove_child(你选取的地块)
    你选取的地块 = null
  # if selected_person != null:
  #   selected_person.unselect()
  #   selected_person = null

func try_click(from: Vector3, direct: Vector3):
  var space_state = get_world_3d().direct_space_state
  var query = PhysicsRayQueryParameters3D.create(from, from + direct)
  query.collide_with_areas = true
  var result = space_state.intersect_ray(query)
  var prev_selected_tile = 你选取的地块
  cancel_selected()
  if result and result.collider is GridMap:

    var location: Vector3i = BASE_GRID_MAP.local_to_map(result.position)
    var selected_location = Vector2i(location.x, location.z)

    var active_db_tile = BackendInstance.get_tile_in_player_level(游戏等级, selected_location.x, selected_location.y)
    if active_db_tile == null:
      active_db_tile = BackendInstance.get_tile_in_base_level(游戏等级, selected_location.x, selected_location.y)

    if active_db_tile == null:
      cancel_selected()
    else:
      var active_db_tile_extend = BackendInstance.get_base_tile(active_db_tile.tile_id)
      你选取的地块 = SelectedTileTscn.instantiate()
      你选取的地块.set_tile(active_db_tile.x, active_db_tile.y, active_db_tile_extend.width, active_db_tile_extend.height)
      add_child(你选取的地块)
      占领地块(Global.PLAYER_YOU, active_db_tile.x, active_db_tile.y)
  elif result and result.collider is Person:
    pass
    # selected_person = result.collider
    # selected_person.selected()

func _physics_process(delta: float) -> void:
  pass

#func person_arrived_tile(person: Person, vector: Vector2i):
  #var tile: TileInfo = null
  #if vector in COVER_MAP:
    #tile = COVER_MAP[vector]
  #elif vector in NATURE_MAP:
    #tile = NATURE_MAP[vector]
  #tile.your = true
  #refresh_owner_in_grid(tile)
