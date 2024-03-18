class_name Attackable

# 类型
var classify: String

# 名字
var name: String

# 备注
var remark: String

# 经验值
var experience: ExperienceBase

# 数量
var count: int = 0

# 属性
var property: PropertyBase

# 装备
var equipments: Array[EquipmentBase]

# 技能
var skills: Array[SkillBase] = []

# 战时属性调整
var wartime_property_adjust: PropertyBase