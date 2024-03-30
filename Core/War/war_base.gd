class_name WarBase

var first_legion: LegionBase
var second_legion: LegionBase

var tie: bool = false
var winner: LegionBase = null

func _init(_first_legion: LegionBase, _second_legion: LegionBase) -> void:
  first_legion = _first_legion
  second_legion = _second_legion

func check_war_end() -> bool:
  var winner_count = 0
  if not first_legion.still_alive():
    winner_count += 1
    winner = second_legion
  if not second_legion.still_alive():
    winner_count += 1
    winner = first_legion
  if winner_count == 2:
    winner = null
    tie = true
  return winner_count > 0

func _sort_with_speed_and_other_property_sorter(a: Attackable, b: Attackable):
  if a.wartime_property.speed > b.wartime_property.speed:
    return true
  elif a.wartime_property.agility > b.wartime_property.agility:
    return true
  elif a.wartime_property.luck > b.wartime_property.luck:
    return true
  else:
    return false

func _sort_with_speed_and_other_property() -> Array[Attackable]:
  var result: Array[Attackable] = []
  for leader in first_legion.leaders:
    result.append(leader)
  for arm in first_legion.arms:
    result.append(arm)
  for leader in second_legion.leaders:
    result.append(leader)
  for arm in second_legion.arms:
    result.append(arm)
  result.sort_custom(_sort_with_speed_and_other_property_sorter)
  return result

func _try_recieve_attack(attack_packages: Array[PropertyAdjustFor]) -> void:
  for adjust in attack_packages:
    var finished_attack = false
    for arm in adjust.target_legion.arms:
      if (adjust.for_classifies.is_empty() and adjust.for_names.is_empty()) or arm.classify in adjust.for_classifies or arm.name in adjust.for_names:
        finished_attack = arm.on_wartime_damage(adjust)
        if finished_attack:
          print('军队 %s 收到攻击 %s' % [str(arm), str(adjust)])
          break
    if not finished_attack:
      for leader in adjust.target_legion.leaders:
        if (adjust.for_classifies.is_empty() and adjust.for_names.is_empty()) or leader.classify in adjust.for_classifies or leader.name in adjust.for_names:
          finished_attack = leader.on_wartime_damage(adjust)
          if finished_attack:
            print('领导 %s 收到攻击 %s' % [str(leader), str(adjust)])
            break

func _wartime_prepare() -> void:
  for a in _sort_with_speed_and_other_property():
    a.wartime_prepare()

func _wartime_prepare_skill() -> bool:
  print('--------------------')
  print('战前准备')
  for a in _sort_with_speed_and_other_property():
    var my_legion = first_legion if a in first_legion.leaders or a in first_legion.arms else second_legion
    var enimy_legion = first_legion if my_legion == second_legion else second_legion
    var pkgs = a.wartime_prepare_skill(my_legion, enimy_legion)
    _try_recieve_attack(pkgs)
    if check_war_end():
      return false
  return true

func _wartime_attack(turn_count: int) -> bool:
  print('--------------------')
  print('第 %d 回合' % turn_count)
  for a in _sort_with_speed_and_other_property():
    var my_legion = first_legion if a in first_legion.leaders or a in first_legion.arms else second_legion
    var enimy_legion = first_legion if my_legion == second_legion else second_legion
    var pkgs = a.wartime_attack(my_legion, enimy_legion)
    _try_recieve_attack(pkgs)
    if check_war_end():
      return false
  return true

func start_war() -> void:
  _wartime_prepare()
  if _wartime_prepare_skill():
    var turn_count = 0
    while _wartime_attack(turn_count):
      turn_count += 1
      continue
  var tmp = []
  tmp.append_array(first_legion.leaders)
  tmp.append_array(second_legion.leaders)
  tmp.append_array(first_legion.arms)
  tmp.append_array(second_legion.arms)
  for t in tmp:
    t.property.life = t.wartime_property.life
    t.property.count = t.wartime_property.count
  print('战斗结束, 平手 = %d, 赢家 = %s' % [1 if tie else 0, str(winner)])
