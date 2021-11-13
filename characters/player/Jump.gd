extends PlayerState


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("jump_up")
	fsm.velocity.y = JUMP_FORCE
	
	
func physics_process(delta : float) -> void:
	if fsm.velocity.y > 0.0:
		fsm.change_state("Fall")
		return
	
	var xInput = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if abs(fsm.velocity.x) > AIR_MOVE_SPEED && sign(xInput) == sign(fsm.velocity.x):
		fsm.velocity.x = lerp(fsm.velocity.x, AIR_MOVE_SPEED * sign(fsm.velocity.x), AIR_FRICTION)
	else:
		fsm.velocity.x = xInput * AIR_MOVE_SPEED
		
	fsm.velocity.y += GRAVITY
	
	if xInput != 0:
		fsm.get_parent().turnAround()
