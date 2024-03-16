extends Node3D

@onready var BASE_GRID_MAP: GridMap = $BaseGridMap

const SelectedTileTscn: PackedScene = preload ("res://Object/SelectedTile/selected_tile.tscn")
const PersonTscn: PackedScene = preload ("res://Object/Person/person.tscn")
const OwnerTileTscn: PackedScene = preload ("res://Object/OwnerTile/owner_tile.tscn")

var NATURE_MAP = {}
var COVER_MAP = {}

var PERSON_MAP = {}

var OWNER_MAP = {}

var selected_location: Vector2i = Vector2i( - 1, -1)
var selected_tile: SelectedTile = null
var selected_person: Person = null

func refresh_owner_in_grid(tile: TileInfo) -> void:
  if tile.location not in OWNER_MAP:
    var owner = OwnerTileTscn.instantiate()
    OWNER_MAP[tile.location] = owner
    add_child(owner)
    owner.set_tile(tile)
  else:
    OWNER_MAP[tile.location].set_tile(tile)

func remove_owner_from_grid(tile: TileInfo) -> void:
  if tile.location in OWNER_MAP:
    remove_child(OWNER_MAP[tile.location])
    OWNER_MAP.erase(tile.location)

func set_tile_in_map(tile: TileInfo, map) -> void:
  var size = tile.detail.size
  var rx = int(size.x / 2)
  var ry = int(size.y / 2)
  for i in range(tile.location.x - rx, tile.location.x + rx + 1):
    for j in range(tile.location.y - ry, tile.location.y + ry + 1):
      map[Vector2i(i, j)] = tile
      BASE_GRID_MAP.set_cell_item(tile.get_tile_location_3d(), tile.item, tile.orientation)

func clear_tile_in_map(tile: TileInfo, map) -> void:
  var size = tile.detail.size
  var rx = int(size.x / 2)
  var ry = int(size.y / 2)
  tile.your = false
  for i in range(tile.location.x - rx, tile.location.x + rx + 1):
    for j in range(tile.location.y - ry, tile.location.y + ry + 1):
      map.erase(Vector2i(i, j))
      BASE_GRID_MAP.set_cell_item(tile.get_tile_location_3d(), -1, 0)

func set_tile_in_grid(tile: TileInfo, map):
  var size = tile.detail.size
  var rx = int(size.x / 2)
  var ry = int(size.y / 2)
  for i in range(tile.location.x - rx, tile.location.x + rx + 1):
    for j in range(tile.location.y - ry, tile.location.y + ry + 1):
      var v = Vector2i(i, j)
      if v in COVER_MAP:
        clear_tile_in_map(COVER_MAP[v], COVER_MAP)
      elif v in NATURE_MAP:
        clear_tile_in_map(NATURE_MAP[v], NATURE_MAP)
  set_tile_in_map(tile, map)

func init_nature():
  var file = FileAccess.open('./nature', FileAccess.READ)
  var save_map: GridMap = file.get_var(true) as GridMap
  for location in save_map.get_used_cells():
    var item = save_map.get_cell_item(location)
    var orientation = save_map.get_cell_item_orientation(location)
    var tile = TileInfo.new(Vector2i(location.x, location.z), item, orientation, false)
    set_tile_in_grid(tile, NATURE_MAP)

func init_cover():
  var castle = TileInfo.new(Vector2i(2, 2), Global.TILE_CASTLE_LV1.item, 0, true)
  set_tile_in_grid(castle, COVER_MAP)
  refresh_owner_in_grid(castle)

func init_person():
  var person: Person = PersonTscn.instantiate()
  person.person_id = 1
  person.origin_location = Vector2i(1, 1)
  person.set_tile(COVER_MAP[Vector2i(1, 1)])
  person.connect('arrived_tile', Callable(self, 'person_arrived_tile'))
  PERSON_MAP[person.person_id] = person
  add_child(person)

func move_person_to_tile(person_id: int, tile: TileInfo):
  if not tile.detail.moveable:
    return
  var ok = false
  for v in tile.get_neighbor_locations():
    if v in NATURE_MAP and NATURE_MAP[v].your:
      ok = true
      break
    if v in COVER_MAP and COVER_MAP[v].your:
      ok = true
      break
  if ok:
    var person = PERSON_MAP[person_id]
    person.move_to_tile(tile)

func _ready():
  init_nature()
  init_cover()
  init_person()

func cancel_selected():
  if selected_location.x != - 1 or selected_location.y != - 1:
    selected_location = Vector2i( - 1, -1)
  if selected_tile != null:
    remove_child(selected_tile)
    selected_tile = null
  if selected_person != null:
    selected_person.unselect()
    selected_person = null

func try_click(from: Vector3, direct: Vector3):
  var space_state = get_world_3d().direct_space_state
  var query = PhysicsRayQueryParameters3D.create(from, from + direct)
  query.collide_with_areas = true
  var result = space_state.intersect_ray(query)
  var prev_location = selected_location
  cancel_selected()
  if result and result.collider is GridMap:
    var location: Vector3i = BASE_GRID_MAP.local_to_map(result.position)
    selected_location = Vector2i(location.x, location.z)
    if selected_location == prev_location:
      cancel_selected()
    elif selected_location in COVER_MAP:
      var tile = COVER_MAP[selected_location]
      selected_tile = SelectedTileTscn.instantiate()
      selected_tile.set_tile(tile)
      add_child(selected_tile)
      move_person_to_tile(1, tile)
    elif selected_location in NATURE_MAP:
      var tile = NATURE_MAP[selected_location]
      selected_tile = SelectedTileTscn.instantiate()
      selected_tile.set_tile(tile)
      add_child(selected_tile)
      move_person_to_tile(1, tile)
    else:
      cancel_selected()
  elif result and result.collider is Person:
    selected_person = result.collider
    selected_person.selected()

func _physics_process(delta: float) -> void:
  pass

func person_arrived_tile(person: Person, vector: Vector2i):
  var tile: TileInfo = null
  if vector in COVER_MAP:
    tile = COVER_MAP[vector]
  elif vector in NATURE_MAP:
    tile = NATURE_MAP[vector]
  tile.your = true
  refresh_owner_in_grid(tile)
