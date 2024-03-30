class_name Attackable

# 唯一编号
var index: int

# 类型
var classify: String

# 名字
var name: String

# 备注
var remark: String

# 经验值
var experience: ExperienceBase = ExperienceBase.new()

# 属性
var property: PropertyBase = PropertyBase.new()

# 装备
var equipments: Array[EquipmentBase]

# 技能
var skills: Array[SkillBase] = []

# 战时属性调整
var wartime_property: PropertyBase = PropertyBase.new()

func still_alive() -> bool:
  return wartime_property.life > 0 and wartime_property.count > 0

func wartime_prepare() -> void:
  wartime_property = property.copy()
  print('%s 准备了属性 %s' % [name, str(wartime_property)])
  for equipment in equipments:
    if classify in equipment.property_adjust_for.for_classifies or name in equipment.property_adjust_for.for_names:
      wartime_property.add(equipment.property_adjust_for)
      print('%s 加强了装备属性 %s', [name, str(equipment.property_adjust_for)])
  print('%s 最终属性 %s' % [name, str(wartime_property)])

func wartime_prepare_skill(my_legion: LegionBase, enimy_legion: LegionBase) -> Array[PropertyAdjustFor]:
  var result: Array[PropertyAdjustFor] = []
  for skill in skills:
    result.append_array(skill.on_wartime_prepare(self, my_legion, enimy_legion))
  return result

func wartime_attack(my_legion: LegionBase, enimy_legion: LegionBase) -> Array[PropertyAdjustFor]:
  var result: Array[PropertyAdjustFor] = []
  for skill in skills:
    result.append_array(skill.on_wartime_attack(self, my_legion, enimy_legion))
  return result

func on_wartime_damage(attack: PropertyAdjustFor) -> bool:
  if not still_alive():
    return false
  for skill in skills:
    skill.on_wartime_damage(self, attack)
  wartime_property.add(attack)
  return true

func _to_string() -> String:
  return 'classify = %s, name = %s' % [classify, name]
