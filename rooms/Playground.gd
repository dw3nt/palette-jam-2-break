extends BaseRoom

const SOUND_SCENE = preload("res://objects/Sound.tscn")


func _ready() -> void:
	emit_signal("room_ready")


func _on_Key_sound_requested(item : PickUpItem, mag : float) -> void:
	var inst = SOUND_SCENE.instance()
	inst.magnitude = mag
	inst.global_position = item.global_position
	add_child(inst)
