extends PlayerState


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("idle")
	
	
func input(event) -> void:
	if fsm.isOnFloor:
		if event.is_action_pressed("move_left") || event.is_action_pressed("move_right"):
			fsm.change_state("Run")
		
		if event.is_action_pressed("jump"):
			fsm.change_state("Jump")
			
		if event.is_action_pressed("crouch"):
			fsm.change_state("Crouch")
			
		if fsm.getHeldItem() && event.is_action_pressed("throw"):
			fsm.change_state("WindUp")
			
			
func physics_process(delta : float) -> void:
	if fsm.velocity.x != 0:
		fsm.velocity.x = lerp(fsm.velocity.x, 0.0, FRICTION)
		if abs(fsm.velocity.x) < LERP_THRESHOLD:
			fsm.velocity.x = 0
			
	if fsm.isOnFloor && (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")):
		fsm.change_state("Run")
			
			
func process(delta : float) -> void:
	if !fsm.isOnFloor:
		fsm.change_state("Fall")
