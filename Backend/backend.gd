extends Node

var skill_map = {
  'DEFAULT': SkillBase.new(),
}

var level_algorithm_map = {
  'DEFAULT': LevelAlgorithmBase.new(),
}

var property_algorithm_map = {
  'DEFAULT': PropertyAlgorithmBase.new(),
}

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

func save_base_equipment(_name: String, classify: String, rarity: int, describe: String, part: int):
  db.insert_row('base_equipment', {
    'name': _name,
    'classify': classify,
    'rarity': rarity,
    'describe': describe,
    'part': part,
  })

func save_base_skill(algorithm_name: String, _name: String, classify: String, rarity: int, describe: String):
  db.insert_row('base_skill', {
    'algorithm_name': algorithm_name,
    'name': _name,
    'classify': classify,
    'rarity': rarity,
    'describe': describe,
  })

func save_base_attackable(
    _name: String,
    type: int,
    classify: String,
    rarity: int,
    describe: String,
    max_life: float,
    strength: float,
    agility: float,
    luck: float,
    intelligence: float,
    speed: float,
    defence: float,
    skill1_id: String,
    skill2_id: String,
    skill3_id: String,
    level_algorithm_when_exp_change: String,
    property_algorithm_when_level_change: String,
  ):
  db.insert_row('base_attackable', {
    'name': _name,
    'type': type,
    'classify': classify,
    'rarity': rarity,
    'describe': describe,
    'max_life': max_life,
    'strength': strength,
    'agility': agility,
    'luck': luck,
    'intelligence': intelligence,
    'speed': speed,
    'defence': defence,
    'skill1_id': skill1_id,
    'skill2_id': skill2_id,
    'skill3_id': skill3_id,
    'level_algorithm_when_exp_change': level_algorithm_when_exp_change,
    'property_algorithm_when_level_change': property_algorithm_when_level_change,
  })

func save_player_level_tile_legion(level_id: int, x: int, y: int, type: int, legion_id: int):
  db.insert_row('player_level_tile_legion', {
    'level_id': level_id,
    'x': x,
    'y': y,
    'type': type,
    'legion_id': legion_id,
  })

func save_player(id: int, _name: String) -> int:
  db.insert_row('player', {
    'id': id,
    'name': _name,
  })
  return db.last_insert_rowid

func save_player_leader(
    player_id: int,
    attackable_id: int,
    experience: int,
    level: int,
    current_life: float,
    equipment_head_id: int=- 1,
    equipment_body_id: int=- 1,
    equipment_pants_id: int=- 1,
    equipment_right_hand_id: int=- 1,
    equipment_left_hand_id: int=- 1,
    equipment_shoe_id: int=- 1,
  ) -> int:
  db.insert_row('player_leader', {
    'player_id': player_id,
    'attackable_id': attackable_id,
    'experience': experience,
    'level': level,
    'current_life': current_life,
    'equipment_head_id': equipment_head_id,
    'equipment_body_id': equipment_body_id,
    'equipment_pants_id': equipment_pants_id,
    'equipment_right_hand_id': equipment_right_hand_id,
    'equipment_left_hand_id': equipment_left_hand_id,
    'equipment_shoe_id': equipment_shoe_id,
  })
  return db.last_insert_rowid

func save_player_arm(player_id, attackable_id, level, current_life, current_count) -> int:
  db.insert_row('player_arm', {
    'player_id': player_id,
    'attackable_id': attackable_id,
    'level': level,
    'current_life': current_life,
    'current_count': current_count,
  })
  return db.last_insert_rowid

func save_player_legion(
    player_id, _name,
    leader1_id, leader2_id, leader3_id,
    arm1_id, arm2_id, arm3_id,
  ) -> int:
  db.insert_row('player_legion', {
    'player_id': player_id,
    'name': _name,
    'leader1_id': leader1_id,
    'leader2_id': leader2_id,
    'leader3_id': leader3_id,
    'arm1_id': arm1_id,
    'arm2_id': arm2_id,
    'arm3_id': arm3_id,
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

  # 固定死的基本地块

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

  # 固定死的装备

  save_base_equipment(
    '木头',
    Global.CLASSIFY_HUMAN,
    Global.RARITY_1,
    '路边随便捡的一个木头',
    Global.EQUIPMENT_PART_RIGHT_HAND,
  )

  save_base_equipment(
    '盾牌',
    Global.CLASSIFY_HUMAN,
    Global.RARITY_1,
    '使用石头制造的盾牌',
    Global.EQUIPMENT_PART_LEFT_HAND,
  )

  save_base_equipment(
    '头盔',
    Global.CLASSIFY_HUMAN,
    Global.RARITY_1,
    '利用纸糊的头盔',
    Global.EQUIPMENT_PART_HEAD,
  )

  save_base_equipment(
    '铠甲',
    Global.CLASSIFY_HUMAN,
    Global.RARITY_1,
    '利用纸糊的铠甲',
    Global.EQUIPMENT_PART_BODY,
  )

  save_base_equipment(
    '裤子',
    Global.CLASSIFY_HUMAN,
    Global.RARITY_1,
    '利用纸糊的裤子',
    Global.EQUIPMENT_PART_PANTS,
  )

  save_base_equipment(
    '鞋子',
    Global.CLASSIFY_HUMAN,
    Global.RARITY_1,
    '利用纸糊的鞋子',
    Global.EQUIPMENT_PART_SHOE,
  )

  # 固定死的技能

  save_base_skill(
    'DEFAULT',
    '普通攻击与防御',
    Global.CLASSIFY_HUMAN,
    Global.RARITY_1,
    '根据属性产生攻击与防御'
  )

  # 固定死的领导

  save_base_attackable(
    '廖伟骅',
    Global.ATTACKABLE_TYPE_LEADER,
    Global.CLASSIFY_HUMAN,
    Global.RARITY_1,
    '出生于台湾的战士',
    100,
    10,
    10,
    10,
    10,
    10,
    0,
    'DEFAULT',
    '',
    '',
    'DEFAULT',
    'DEFAULT',
  )

  # 固定死的兵种

  save_base_attackable(
    '小混混',
    Global.ATTACKABLE_TYPE_ARM,
    Global.CLASSIFY_HUMAN,
    Global.RARITY_1,
    '出生于台湾的混混们',
    100,
    10,
    10,
    10,
    10,
    10,
    0,
    'DEFAULT',
    '',
    '',
    '',
    '',
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
          level_id =%d
      ) base_level_tile
      inner join base_tile on base_tile.id = base_level_tile.tile_id
    where
      %d >= base_level_tile.x - cast(base_tile.width / 2 as integer) and
      %d >= base_level_tile.y - cast(base_tile.height / 2 as integer) and
      %d <= base_level_tile.x + cast(base_tile.width / 2 as integer) and
      %d <= base_level_tile.y + cast(base_tile.height / 2 as integer)
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
          level_id =%d
      ) player_level_tile_build
      inner join base_tile on base_tile.id = player_level_tile_build.tile_id
    where
      %d >= player_level_tile_build.x - cast(base_tile.width / 2 as integer) and
      %d >= player_level_tile_build.y - cast(base_tile.height / 2 as integer) and
      %d <= player_level_tile_build.x + cast(base_tile.width / 2 as integer) and
      %d <= player_level_tile_build.y + cast(base_tile.height / 2 as integer)
  ''' % [level_id, x, y, x, y])
  return null if db.query_result.is_empty() else db.query_result[0]

func load_base_level_tile(level_id) -> Array[Dictionary]:
  return db.select_rows('base_level_tile', 'level_id = %d' % [level_id], ['*'])

func load_player_level_tile(level_id) -> Array[Dictionary]:
   return db.select_rows('player_level_tile_build', 'level_id = %d' % [level_id], ['*'])

func random_player_leader(player_id, classify, rarity) -> int:
  var enable_leaders = db.select_rows('base_attackable', 'type = %d and classify = "%s" and rarity = %d' % [Global.ATTACKABLE_TYPE_LEADER, classify, rarity], ['*'])
  var random_one = enable_leaders[randi() % enable_leaders.size()]
  return save_player_leader(
    player_id,
    random_one.id,
    1, 1, random_one.max_life,
  )

func random_player_arm(player_id, classify, rarity, c=100) -> int:
  var enable_arms = db.select_rows('base_attackable', 'type = %d and classify = "%s" and rarity = %d' % [Global.ATTACKABLE_TYPE_ARM, classify, rarity], ['*'])
  var random_one = enable_arms[randi() % enable_arms.size()]
  return save_player_arm(
    player_id,
    random_one.id,
    1, random_one.max_life, c,
  )

func random_player_legion(player_id, _name, classify, rarity, c=100) -> int:
  return save_player_legion(
    player_id, _name,
    random_player_leader(player_id, classify, rarity),
    -1,
    -1,
    random_player_arm(player_id, classify, rarity, c),
    -1,
    -1,
  )
