extends PlayerState


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("crouch_run")
	
	
func input(event) -> void:
	if event.is_action_released("crouch"):
		fsm.change_state("Run")
		
		
func physics_process(delta : float) -> void:
	if !fsm.isOnFloor:
		fsm.change_state("Fall")
		return
	
	var xInput = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if xInput == 0: 
		fsm.change_state("Crouch")
		return
		
	fsm.velocity.x = xInput * CROUCH_SPEED
	fsm.get_parent().turnAround()
