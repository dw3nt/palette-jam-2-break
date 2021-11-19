extends GuardState


func enter_state(params : Dictionary = {}) -> void:
	fsm.anim.play("alert")
	fsm.velocity.y = JUMP_FORCE
	
	
func physics_process(delta : float) -> void:
	if fsm.isOnFloor:
		fsm.change_state("Chase")
		return
		
	slideToHalt()
	fsm.velocity.y += GRAVITY
