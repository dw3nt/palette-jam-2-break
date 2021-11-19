extends GuardState

const TARGET_POS_OFFSET := Vector2(0, -12)


func enter_state(params : Dictionary = {}) -> void:
	fsm.anim.play("run")
	
	
func physics_process(delta : float) -> void:
	if !canSeeChaseTarget():
		fsm.change_state("Patrol")
		return
	
	var moveDirX = sign(fsm.chaseTarget.sightDetect.global_position.x - global_position.x)
	fsm.velocity.x = moveDirX * CHASE_SPEED
	
	handleFacing(moveDirX)
	
	
func canSeeChaseTarget() -> bool:
	var isInVisionCone = .canSeeChaseTarget()
	return isInVisionCone
	
	
func exit_state() -> void:
	fsm.exclaimationSprite.visible = false


func _on_ChaseableRangeDetect_body_exited(body : Player) -> void:
	if !body:
		return
