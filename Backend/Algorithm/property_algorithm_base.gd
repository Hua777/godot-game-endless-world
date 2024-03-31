class_name PropertyAlgorithmBase

func get_algorithm_name() -> String:
  return 'DEFAULT'
  
func count_property(_level: int, _value: float) -> float:
  return _value * _level