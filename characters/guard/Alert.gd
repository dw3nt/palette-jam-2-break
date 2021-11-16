extends GuardState

var target : Player


func enter_state(params : Dictionary = {}) -> void:
	fsm.anim.play("alert")
	target = params.target
	fsm.velocity.y = JUMP_FORCE
	
	
func physics_process(delta : float) -> void:
	if fsm.isOnFloor:
		fsm.change_state("Chase", { "target" : target })
		return
		
	slideToHalt()
	fsm.velocity.y += GRAVITY
