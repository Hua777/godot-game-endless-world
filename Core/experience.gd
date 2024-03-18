class_name Experience

const LEVEL_EXP = [0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 11000, 12000, 13000, 14000, ]

var total_number: int = 0

func get_level() -> int:
  return Experience.get_level_by_number(total_number)

func add_exp(input_exp: int) -> bool:
  var prev_level = Experience.get_level_by_number(total_number)
  total_number += input_exp
  var next_level = Experience.get_level_by_number(total_number)
  return prev_level != next_level

static func get_level_by_number(number: int) -> int:
  for e in LEVEL_EXP:
    if number <= e:
      return LEVEL_EXP.find(e)
  return LEVEL_EXP.size()
