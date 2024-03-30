extends Node

var db: SQLite = DatabaseInstance.get_db()

func save_base_tile(
    id: int, type: int, moveable: int, _name: String, width: int, height: int, level: int,
    food_per_second: float,
    wood_per_second: float,
    stone_per_second: float,
    gold_per_second: float,
    diamond_per_second: float,
  ):
  db.insert_row('base_tile', {
    'id': id,
    'type': type,
    'moveable': moveable,
    'name': _name,
    'width': width,
    'height': height,
    'level': level,
    'food_per_second': food_per_second,
    'wood_per_second': wood_per_second,
    'stone_per_second': stone_per_second,
    'gold_per_second': gold_per_second,
    'diamond_per_second': diamond_per_second,
  })

func save_base_level(id: int):
  db.insert_row('base_level', {
    'id': id,
  })

func save_base_level_tile(level_id: int, x: int, y: int, tile_id: int, orientation: int):
  db.insert_row('base_level_tile', {
    'level_id': level_id,
    'x': x,
    'y': y,
    'tile_id': tile_id,
    'orientation': orientation,
  })

func save_base_level_tile_build(level_id: int, x: int, y: int, tile_id: int, orientation: int, owner_group: int):
  db.insert_row('base_level_tile_build', {
    'level_id': level_id,
    'x': x,
    'y': y,
    'tile_id': tile_id,
    'orientation': orientation,
    'owner_group': owner_group,
  })

func save_player(id: int, _name: String) -> int:
  db.insert_row('player', {
    'id': id,
    'name': _name,
  })
  return db.last_insert_rowid

func remove_player_level_tile_build(level_id, x, y):
  db.delete_rows('player_level_tile_build', 'level_id = %d and x = %d and y = %d' % [level_id, x, y])

func save_player_level_tile_build(level_id, x, y, tile_id, orientation, player_id):
  if db.select_rows('player_level_tile_build', 'level_id = %d and x = %d and y = %d' % [level_id, x, y], ['*']).is_empty():
    db.insert_row('player_level_tile_build', {
      'level_id': level_id,
      'x': x,
      'y': y,
      'tile_id': tile_id,
      'orientation': orientation,
      'player_id': player_id,
    })
  else:
    db.update_rows('player_level_tile_build', 'level_id = %d and x = %d and y = %d' % [level_id, x, y], {
      'tile_id': tile_id,
      'orientation': orientation,
      'player_id': player_id,
    })

func init_base_data():
  save_base_tile(
    0, Global.TILE_TYPE_NATURE, Global.TILE_MOVEABLE, '草地', 1, 1, 1,
    0,
    0,
    0,
    0,
    0,
  )

  save_base_tile(
    1, Global.TILE_TYPE_NATURE, Global.TILE_MOVEABLE, '泥地', 1, 1, 1,
    0,
    0,
    0,
    0,
    0,
  )

  save_base_tile(
    2, Global.TILE_TYPE_NATURE, not Global.TILE_MOVEABLE, '水', 1, 1, 1,
    0,
    0,
    0,
    0,
    0,
  )

  save_base_tile(
    3, Global.TILE_TYPE_NATURE, Global.TILE_MOVEABLE, '木头', 1, 1, 1,
    0,
    1,
    0,
    0,
    0,
  )

  save_base_tile(
    4, Global.TILE_TYPE_NATURE, Global.TILE_MOVEABLE, '石头', 1, 1, 1,
    0,
    0,
    1,
    0,
    0,
  )

  save_base_tile(
    5, Global.TILE_TYPE_NATURE, Global.TILE_MOVEABLE, '粮食', 1, 1, 1,
    1,
    0,
    0,
    0,
    0,
  )

  save_base_tile(
    6, Global.TILE_TYPE_BUILD, Global.TILE_MOVEABLE, '主堡', 3, 3, 1,
    0,
    0,
    0,
    0,
    0,
  )

func init_player_level_tile_build(level_id):
  if db.select_rows('player_level_tile_build', 'level_id = %d' % [level_id], ['*']).is_empty():
    for t in db.select_rows('base_level_tile_build', 'level_id = %d' % [level_id], ['*']):
      save_player_level_tile_build(
        level_id,
        t.x,
        t.y,
        t.tile_id,
        t.orientation,
        t.owner_group,
      )

func get_base_tile(id: int) -> Dictionary:
  return db.select_rows('base_tile', 'id = %d' % [id], ['*'])[0]

func get_tile_in_base_level(level_id: int, x: int, y: int):
  db.query('''
    select
      base_level_tile.*
    from
      (
        select
          *
        from
          base_level_tile
        where
          level_id = %d
      ) base_level_tile
      inner join base_tile on base_tile.id = base_level_tile.tile_id
    where
      %d >= base_level_tile.x - cast(base_tile.width / 2 as integer)
      and %d >= base_level_tile.y - cast(base_tile.height / 2 as integer)
      and %d <= base_level_tile.x + cast(base_tile.width / 2 as integer)
      and %d <= base_level_tile.y + cast(base_tile.height / 2 as integer)
  ''' % [level_id, x, y, x, y])
  return null if db.query_result.is_empty() else db.query_result[0]

func get_tile_in_player_level(level_id: int, x: int, y: int):
  db.query('''
    select
      player_level_tile_build.*
    from
      (
        select
          *
        from
          player_level_tile_build
        where
          level_id = %d
      ) player_level_tile_build
      inner join base_tile on base_tile.id = player_level_tile_build.tile_id
    where
      %d >= player_level_tile_build.x - cast(base_tile.width / 2 as integer)
      and %d >= player_level_tile_build.y - cast(base_tile.height / 2 as integer)
      and %d <= player_level_tile_build.x + cast(base_tile.width / 2 as integer)
      and %d <= player_level_tile_build.y + cast(base_tile.height / 2 as integer)
  ''' % [level_id, x, y, x, y])
  return null if db.query_result.is_empty() else db.query_result[0]

func load_base_level_tile(level_id) -> Array[Dictionary]:
  return db.select_rows('base_level_tile', 'level_id = %d' % [level_id], ['*'])

func load_player_level_tile(level_id) -> Array[Dictionary]:
   return db.select_rows('player_level_tile_build', 'level_id = %d' % [level_id], ['*'])
