extends PlayerState


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("jump_down")
	
	
func physics_process(delta : float) -> void:
	var xInput = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if fsm.isOnFloor:
		if xInput == 0:
			fsm.change_state("Idle")
		else:
			fsm.change_state("Run")
		return
		
	fsm.velocity.y += GRAVITY
	if abs(fsm.velocity.x) > AIR_MOVE_SPEED && sign(xInput) == sign(fsm.velocity.x):
		fsm.velocity.x = lerp(fsm.velocity.x, AIR_MOVE_SPEED * sign(fsm.velocity.x), AIR_FRICTION)
	else:
		fsm.velocity.x = xInput * AIR_MOVE_SPEED
		
	if xInput != 0:
		fsm.get_parent().turnAround()
	
	
func exit_state() -> void:
	fsm.velocity.y = GRAVITY
