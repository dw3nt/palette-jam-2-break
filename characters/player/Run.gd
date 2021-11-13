extends PlayerState


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("run")
	
	
func input(event) -> void:
	if event.is_action_pressed("crouch"):
		fsm.change_state("Crouch")
		
	if event.is_action_pressed("jump"):
		fsm.change_state("Jump")
	
	
func physics_process(delta : float) -> void:
	var xInput = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if xInput == 0:
		print('run to idle')
		fsm.change_state("Idle")
		return
		
	fsm.velocity.x = xInput * MOVE_SPEED
