extends Node

var db_name = 'res://Database/endless_world'

var _db: SQLite = null

func get_db() -> SQLite:
  if _db == null:
    _db = SQLite.new()
    _db.path = db_name
    _db.verbosity_level = SQLite.QUIET
    _db.open_db()
  return _db

func init_db():
  var db = get_db()

  # 基础配置

  db.query('''
    create table if not exists base_config (
      id INTEGER PRIMARY KEY NOT NULL
    )
  ''')

  # 基础关卡

  db.query('''
    create table if not exists base_level (
      id INTEGER PRIMARY KEY NOT NULL
    )
  ''')

  # 基础地块

  db.query('''
    create table if not exists base_tile (
      id INTEGER PRIMARY KEY NOT NULL,
      type INTEGER NOT NULL,
      moveable INTEGER NOT NULL,
      name VARCHAR(128) NOT NULL,
      width INTEGER NOT NULL,
      height INTEGER NOT NULL,
      level INTEGER NOT NULL,
      food_per_second REAL NOT NULL,
      wood_per_second REAL NOT NULL,
      stone_per_second REAL NOT NULL,
      gold_per_second REAL NOT NULL,
      diamond_per_second REAL NOT NULL
    )
  ''')

  # 关卡地块

  db.query('''
    create table if not exists base_level_tile (
      level_id INTEGER NOT NULL,
      x INTEGER NOT NULL,
      y INTEGER NOT NULL,
      tile_id INTEGER NOT NULL,
      orientation INTEGER NOT NULL,
      PRIMARY KEY (level_id, x, y)
    )
  ''')

  # 关卡默认建筑

  db.query('''
    create table if not exists base_level_tile_build (
      level_id INTEGER NOT NULL,
      x INTEGER NOT NULL,
      y INTEGER NOT NULL,
      tile_id INTEGER NOT NULL,
      orientation INTEGER NOT NULL,
      owner_group INTEGER NOT NULL,
      PRIMARY KEY (level_id, x, y)
    )
  ''')

  # 基础装备

  db.query('''
    create table if not exists base_equipment (
      id INTEGER PRIMARY KEY NOT NULL,
      name VARCHAR(128) NOT NULL,
      classify VARCHAR(128) NOT NULL,
      rarity INTEGER NOT NULL,
      describe TEXT NOT NULL,
      part INTEGER NOT NULL
    )
  ''')

  # 基础技能

  db.query('''
    create table if not exists base_skill (
      algorithm_name VARCHAR(128) PRIMARY KEY NOT NULL,
      name VARCHAR(128) NOT NULL,
      classify VARCHAR(128) NOT NULL,
      rarity INTEGER NOT NULL,
      describe TEXT NOT NULL
    )
  ''')

  # 基础领导、兵种

  db.query('''
    create table if not exists base_attackable (
      id INTEGER PRIMARY KEY NOT NULL,
      name VARCHAR(128) NOT NULL,
      type INTEGER NOT NULL,
      classify VARCHAR(128) NOT NULL,
      rarity INTEGER NOT NULL,
      describe TEXT NOT NULL,
      max_life REAL NOT NULL,
      strength REAL NOT NULL,
      agility REAL NOT NULL,
      luck REAL NOT NULL,
      intelligence REAL NOT NULL,
      speed REAL NOT NULL,
      defence REAL NOT NULL,
      skill1_id VARCHAR(128) NOT NULL,
      skill2_id VARCHAR(128) NOT NULL,
      skill3_id VARCHAR(128) NOT NULL,
      level_algorithm_when_exp_change VARCHAR(128) NOT NULL,
      property_algorithm_when_level_change VARCHAR(128) NOT NULL
    )
  ''')

  # 玩家

  db.query('''
    create table if not exists player (
      id INTEGER PRIMARY KEY NOT NULL,
      name VARCHAR(128) NOT NULL
    )
  ''')

  # 玩家玩过的关卡地块信息

  db.query('''
    create table if not exists player_level_tile_build (
      level_id INTEGER NOT NULL,
      x INTEGER NOT NULL,
      y INTEGER NOT NULL,
      tile_id INTEGER NOT NULL,
      orientation INTEGER NOT NULL,
      player_id INTEGER NOT NULL,
      PRIMARY KEY (level_id, x, y)
    )
  ''')

  # 玩家的装备信息

  db.query('''
    create table if not exists player_equipment (
      id INTEGER PRIMARY KEY NOT NULL,
      player_id INTEGER NOT NULL,
      equipment_id INTEGER NOT NULL,
      max_life REAL NOT NULL,
      strength REAL NOT NULL,
      agility REAL NOT NULL,
      luck REAL NOT NULL,
      intelligence REAL NOT NULL,
      speed REAL NOT NULL,
      defence REAL NOT NULL
    )
  ''')

  # 玩家的领导信息

  db.query('''
    create table if not exists player_leader (
      id INTEGER PRIMARY KEY NOT NULL,
      player_id INTEGER NOT NULL,
      attackable_id INTEGER NOT NULL,
      experience INTEGER NOT NULL,
      level INTEGER NOT NULL,
      current_life REAL NOT NULL,
      equipment_head_id INTEGER NOT NULL,
      equipment_body_id INTEGER NOT NULL,
      equipment_pants_id INTEGER NOT NULL,
      equipment_right_hand_id INTEGER NOT NULL,
      equipment_left_hand_id INTEGER NOT NULL,
      equipment_shoe_id INTEGER NOT NULL
    )
  ''')

  # 玩家的兵种信息

  db.query('''
    create table if not exists player_arm (
      player_id INTEGER NOT NULL,
      attackable_id INTEGER NOT NULL,
      level INTEGER NOT NULL,
      current_life REAL NOT NULL,
      current_count INTEGER NOT NULL,
      PRIMARY KEY (player_id, attackable_id)
    )
  ''')

  # 玩家的军团信息

  db.query('''
    create table if not exists player_legion (
      id INTEGER PRIMARY KEY NOT NULL,
      player_id INTEGER NOT NULL,
      name VARCHAR(128) NOT NULL,
      leader1_id INTEGER NOT NULL,
      leader2_id INTEGER NOT NULL,
      leader3_id INTEGER NOT NULL,
      arm1_id INTEGER NOT NULL,
      arm2_id INTEGER NOT NULL,
      arm3_id INTEGER NOT NULL
    )
  ''')

  # 地块驻扎的军团

  db.query('''
    create table if not exists player_level_tile_legion (
      level_id INTEGER NOT NULL,
      x INTEGER NOT NULL,
      y INTEGER NOT NULL,
      type INTEGER NOT NULL,
      legion_id INTEGER NOT NULL,
      PRIMARY KEY (level_id, x, y, legion_id)
    )
  ''')

  # 玩家战争记录

  db.query('''
    create table if not exists player_level_war (
      id INTEGER PRIMARY KEY NOT NULL,
      player_id INTEGER NOT NULL,
      player_level_id INTEGER NOT NULL,
      x INTEGER NOT NULL,
      y INTEGER NOT NULL,
      from_legion_begin TEXT NOT NULL,
      to_legion_begin TEXT NOT NULL,
      from_legion_end TEXT NOT NULL,
      to_legion_end TEXT NOT NULL,
      tie INTEGER NOT NULL,
      winner_legion TEXT NOT NULL,
      create_time INTEGER NOT NULL
    )
  ''')

func close_db():
  _db.close_db()
