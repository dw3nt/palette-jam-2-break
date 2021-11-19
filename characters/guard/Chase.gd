extends GuardState

const TARGET_POS_OFFSET := Vector2(0, -12)

var isTargetInChaseRange : bool = false


func enter_state(params : Dictionary = {}) -> void:
	fsm.anim.play("run")
	
	
func physics_process(delta : float) -> void:
	if !shouldChaseTarget():
		fsm.change_state("Patrol")
		return
	
	var moveDirX = sign(fsm.chaseTarget.sightDetect.global_position.x - global_position.x)
	fsm.velocity.x = moveDirX * CHASE_SPEED
	
	handleFacing(moveDirX)
	
	
func shouldChaseTarget() -> bool:
	var isInVisionCone = canSeeChaseTarget()
	if !isInVisionCone && !isTargetInChaseRange:
		return false
		
	return true
	
	
func exit_state() -> void:
	fsm.exclaimationSprite.visible = false


func _on_ChaseableRangeDetect_area_entered(area : Area2D) -> void:
	isTargetInChaseRange = true


func _on_ChaseableRangeDetect_area_exited(area : Area2D) -> void:
	isTargetInChaseRange = false
