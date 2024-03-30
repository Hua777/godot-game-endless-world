class_name SkillBase

var name: String = '普通攻击与防御'

var describe: String = '根据属性产生攻击与防御'

func on_wartime_prepare(owner: Attackable, my_legion: LegionBase, enimy_legion: LegionBase) -> Array[PropertyAdjustFor]:
  return []

func on_wartime_attack(owner: Attackable, my_legion: LegionBase, enimy_legion: LegionBase) -> Array[PropertyAdjustFor]:
  print('%s 发起攻击，释放技能 %s' % [owner.name, name])
  var normal = PropertyAdjustFor.new()
  normal.target_legion = enimy_legion
  normal.life = -owner.wartime_property.strength
  return [normal]

func on_wartime_damage(owner: Attackable, attack: PropertyAdjustFor) -> void:
  if attack.life < 0:
    print('%s 受到攻击，发动技能 %s' % [owner.name, name])
    attack.life += owner.wartime_property.defence
    if attack.life > 0:
      attack.life = 0

func _to_string() -> String:
  return 'name = %s, describe = %s' % [
    name,
    describe
  ]
