extends PlayerState

onready var standDetects = [ $StandDetectLeft, $StandDetectMiddle, $StandDetectRight ]


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("crouch_run")
	
	
func input(event) -> void:
	if event.is_action_released("crouch") && !standDetectsColliding():
		fsm.change_state("Run")
		
	if event.is_action_pressed("throw"):
		fsm.change_state("WindUp", { "isCrouched" : true })
		
		
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
	
	if !standDetectsColliding() && !Input.is_action_pressed("crouch"):
		fsm.change_state("Run")
		return
		
		
func standDetectsColliding() -> bool:
	for ray in standDetects:
		if ray.is_colliding():
			return true
			
	return false
