extends GuardState

var target : Player

onready var targetSight = $TargetSightDetect as RayCast2D


func enter_state(params : Dictionary = {}) -> void:
	targetSight.enabled = true
	fsm.anim.play("run")
	target = params.target
	
	
func physics_process(delta : float) -> void:
	if !canSeeTarget():
		fsm.change_state("Patrol")
	
	var moveDirX = sign(target.global_position.x - global_position.x)
	fsm.velocity.x = moveDirX * CHASE_SPEED
	
	handleFacing(moveDirX)
	
	
func canSeeTarget() -> bool:
	var distanceToTarget = global_position.distance_to(target.global_position)
	targetSight.cast_to = (target.global_position - targetSight.global_position).normalized() * distanceToTarget
	
	return !targetSight.is_colliding()
	
	
func exit_state() -> void:
	targetSight.enabled = false
	fsm.exclaimationSprite.visible = false
