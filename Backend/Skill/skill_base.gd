class_name SkillBase

func get_algorithm_name() -> String:
  return 'DEFAULT'

# 战前准备
func on_wartime_prepare(owner: Attackable, my_legion: LegionBase, enimy_legion: LegionBase) -> Array[PropertyAdjustFor]:
  return []

# 战时攻击
func on_wartime_attack(owner: Attackable, my_legion: LegionBase, enimy_legion: LegionBase) -> Array[PropertyAdjustFor]:
  var normal = PropertyAdjustFor.new()
  normal.target_legion = enimy_legion
  normal.life = -owner.wartime_property.strength
  return [normal]

# 战时防御
func on_wartime_damage(owner: Attackable, attack: PropertyAdjustFor) -> void:
  if attack.life < 0:
    attack.life += owner.wartime_property.defence
    if attack.life > 0:
      attack.life = 0
