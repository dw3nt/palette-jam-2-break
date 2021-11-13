extends BaseRoom


func _ready() -> void:
	var message = params.message if params.keys().has("message") else ""
	print(message)
	emit_signal("room_ready")
