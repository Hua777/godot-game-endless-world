class_name SkillBase

var name: String = '无'

var describe: String = '无'

func use_in_prepare(attack_package: AttackPackage) -> void:
  pass

func use_in_attack(attack_package: AttackPackage) -> void:
  pass
  
func use_after_dead(attack_package: AttackPackage) -> void:
  pass