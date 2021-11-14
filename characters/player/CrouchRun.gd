extends PlayerState

onready var standDetect = $StandDetect as RayCast2D


func enter_state(_params : Dictionary = {}) -> void:
	standDetect.enabled = true
	fsm.anim.play("crouch_run")
	
	
func input(event) -> void:
	if event.is_action_released("crouch") && !standDetect.is_colliding():
		print('input run')
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
	
	if !standDetect.is_colliding() && !Input.is_action_pressed("crouch"):
		print('physicis run')
		fsm.change_state("Run")
		return
	
	
func exit_state() -> void:
	standDetect.enabled = false
