extends PlayerState

onready var standDetects = [ $StandDetectLeft, $StandDetectMiddle, $StandDetectRight ]


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("crouch", -1, 0.5)
	
	
func input(event) -> void:
	if !standDetectsColliding() && event.is_action_released("crouch"):
		fsm.change_state("Idle")
	
#	if event.is_action_pressed("move_right") || event.is_action_pressed("move_left"):
#		fsm.change_state("CrouchRun")
		
	if event.is_action_pressed("throw"):
		fsm.change_state("WindUp", { "isCrouched" : true })
		
		
func physics_process(delta : float) -> void:
	if fsm.velocity.x != 0:
		fsm.velocity.x = lerp(fsm.velocity.x, 0.0, FRICTION)
		if abs(fsm.velocity.x) < LERP_THRESHOLD:
			fsm.velocity.x = 0
			
	if fsm.isOnFloor && (Input.get_action_strength("move_right") - Input.get_action_strength("move_left") != 0):
		fsm.change_state("CrouchRun")
		
	if !standDetectsColliding() && !Input.is_action_pressed("crouch"):
		fsm.change_state("Idle")
		
		
func standDetectsColliding() -> bool:
	for ray in standDetects:
		if ray.is_colliding():
			return true
			
	return false
