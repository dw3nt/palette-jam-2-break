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
		
	if fsm.velocity.x != 0:
		fsm.velocity.x = lerp(fsm.velocity.x, 0.0, FRICTION)
		if abs(fsm.velocity.x) < LERP_THRESHOLD:
			fsm.velocity.x = 0
	
	fsm.velocity.y += GRAVITY
