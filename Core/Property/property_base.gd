class_name PropertyBase

# 生命最大值
var max_life: float = 0

# 生命值
var life: float = 0

# 力量（影响普通攻击）
var strength: float = 0

# 敏捷（影响攻击速度）
var agility: float = 0

# 幸运（影响闪避）
var luck: float = 0

# 智力（影响魔法攻击）
var intelligence: float = 0

# 速度（影响移动速度）
var speed: float = 0

# 防御
var defence: float = 0

# 数量
var count: int = 0

func copy() -> PropertyBase:
  var result = PropertyBase.new()
  result.max_life = max_life
  result.life = life
  result.strength = strength
  result.agility = agility
  result.luck = luck
  result.intelligence = intelligence
  result.speed = speed
  result.defence = defence
  result.count = count
  return result

func add(property: PropertyBase) -> void:
  max_life += property.max_life
  life += property.life
  strength += property.strength
  agility += property.agility
  luck += property.luck
  intelligence += property.intelligence
  speed += property.speed
  defence += property.defence
  count += property.count
  while life < 0:
    life += max_life
    count -= 1

func _to_string() -> String:
  return 'life = %.2f, strength = %.2f, agility = %.2f, luck = %.2f, intelligence = %.2f, speed = %.2f, defence = %.2f, count = %.2f' % [
    life,
    strength,
    agility,
    luck,
    intelligence,
    speed,
    defence,
    count
  ]
