class_name TileBase

# 可否移动此处
var moveable: bool

# 宽度
var width: int

# 长度
var height: int

# 等级
var level: int

# Grid Map 的 item
var grid_map_item_id: int

# 名称
var name: String

func get_food_per_second() -> float:
  return 0

func get_wood_per_second() -> float:
  return 0

func get_stone_per_second() -> float:
  return 0

func get_gold_per_second() -> float:
  return 0

func get_diamond_per_second() -> float:
  return 0