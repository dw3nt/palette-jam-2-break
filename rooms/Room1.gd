extends BaseRoom


func _ready() -> void:
	emit_signal("room_ready")
