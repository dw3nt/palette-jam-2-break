extends BaseMenu


func _ready():
	emit_signal('room_ready')
	yield(get_tree().create_timer(1.0), "timeout")
	emit_signal("room_change_requested", RoomVars.new(nextScene, TransitionsLoader.Transitions.SwipeToMiddle, 0.0))
