class_name LevelAlgorithmBase

func get_algorithm_name() -> String:
  return 'DEFAULT'

func count_level(_exp: int) -> int:
  return int(_exp / 1000)
