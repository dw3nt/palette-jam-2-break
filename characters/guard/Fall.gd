extends GuardState


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("fall")
	
	
func physics_process(delta : float) -> void:
	var xInput = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if fsm.isOnFloor:
		if randf() > 0.5:
			fsm.change_state("Idle")
		else:
			fsm.change_state("Patrol")
		return
		
	fsm.velocity.y += GRAVITY
	if abs(fsm.velocity.x) > AIR_MOVE_SPEED && sign(xInput) == sign(fsm.velocity.x):
		fsm.velocity.x = lerp(fsm.velocity.x, AIR_MOVE_SPEED * sign(fsm.velocity.x), AIR_FRICTION)
	else:
		fsm.velocity.x = xInput * AIR_MOVE_SPEED
	
	
func exit_state() -> void:
	fsm.velocity.y = GRAVITY
