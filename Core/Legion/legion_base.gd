class_name LegionBase

var leaders: Array[LeaderBase] = []

var arms: Array[ArmBase] = []

func wartime_prepare(legion: LegionBase) -> void:
  for leader in leaders:
    leader.wartime_property_adjust = PropertyBase.new()
  for arm in arms:
    arm.wartime_property_adjust = PropertyBase.new()

func attack(legion: LegionBase) -> Array[AttackPackage]:
  return []

func defense(package: AttackPackage) -> AttackPackage:
  return package