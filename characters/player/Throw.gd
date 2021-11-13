extends PlayerState

onready var timer = $Timer as Timer


func enter_state(params : Dictionary = {}) -> void:
	fsm.anim.play("throw")
	timer.start()
	
	fsm.get_parent().heldItem.throw(params.scale, params.scale)
	fsm.get_parent().heldItem = null
	
	
func physics_process(delta : float) -> void:
	if fsm.velocity.x != 0:
		fsm.velocity.x = lerp(fsm.velocity.x, 0.0, FRICTION)
		if abs(fsm.velocity.x) < LERP_THRESHOLD:
			fsm.velocity.x = 0


func _on_Timer_timeout() -> void:
	fsm.change_state("Idle")
