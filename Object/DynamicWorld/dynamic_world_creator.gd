extends GridMap

func _ready() -> void:
  var file = FileAccess.open('./nature', FileAccess.WRITE)
  file.store_var(self, true)

func _process(delta: float) -> void:
  pass
