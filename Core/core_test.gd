extends Node

func _ready() -> void:

  DatabaseInstance.init_db()

  BackendInstance.init_base_data()

  DatabaseInstance.close_db()

  #var legion_a = LegionBase.new()
  #legion_a.name = '亡灵军团'
  #var legion_a_leader = Attackable.new()
  #legion_a_leader.classify = '不死族'
  #legion_a_leader.property.max_life = 200.0
  #legion_a_leader.property.life = 200.0
  #legion_a_leader.property.strength = 10.0
  #legion_a_leader.property.defence = 2.0
  #legion_a_leader.property.count = 1
  #legion_a_leader.name = '小盒子'
  #var legion_a_leader_skill = SkillBase.new()
  #legion_a_leader.skills.append(legion_a_leader_skill)
  #legion_a.leaders.append(legion_a_leader)
#
  #var legion_b = LegionBase.new()
  #legion_b.name = '圣战军团'
  #var legion_b_leader = Attackable.new()
  #legion_b_leader.classify = '人类'
  #legion_b_leader.property.max_life = 200.0
  #legion_b_leader.property.life = 200.0
  #legion_b_leader.property.strength = 30.0
  #legion_b_leader.property.defence = 5.0
  #legion_b_leader.property.count = 1
  #legion_b_leader.name = '马斯克'
  #var legion_b_leader_skill = SkillBase.new()
  #legion_b_leader.skills.append(legion_b_leader_skill)
  #legion_b.leaders.append(legion_b_leader)
#
  #var war = WarBase.new(legion_a, legion_b)
  #war.start_war()
