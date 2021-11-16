extends PlayerState

var throwAnim = "throw"

onready var timer = $Timer as Timer


func enter_state(params : Dictionary = {}) -> void:
	throwAnim = params.throwAnim
	fsm.anim.play(throwAnim)
	timer.start()
	
	fsm.get_parent().heldItem.throw(params.throwDir, params.scale)
	fsm.get_parent().heldItem.isHeld = false
	fsm.get_parent().heldItem = null
	
	
func physics_process(delta : float) -> void:
	if fsm.velocity.x != 0:
		fsm.velocity.x = lerp(fsm.velocity.x, 0.0, FRICTION)
		if abs(fsm.velocity.x) < LERP_THRESHOLD:
			fsm.velocity.x = 0


func _on_Timer_timeout() -> void:
	if throwAnim == "crouch_throw" && Input.is_action_pressed("crouch"):
		fsm.change_state("Crouch")
	else:
		fsm.change_state("Idle")
