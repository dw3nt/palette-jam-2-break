extends GuardState

const TARGET_POS_OFFSET := Vector2(0, -12)

var target : Player

onready var targetSight = $TargetSightDetect as RayCast2D


func enter_state(params : Dictionary = {}) -> void:
	targetSight.enabled = true
	fsm.anim.play("run")
	target = params.target
	
	
func process(delta : float) -> void:
	if !canSeeTarget():
		fsm.change_state("Patrol")
	
	
func physics_process(delta : float) -> void:
	var moveDirX = sign(target.global_position.x - global_position.x)
	fsm.velocity.x = moveDirX * CHASE_SPEED
	
	handleFacing(moveDirX)
	
	
func canSeeTarget() -> bool:
	var targetPos = target.global_position + TARGET_POS_OFFSET
	var distanceToTarget = targetSight.global_position.distance_to(targetPos)
	targetSight.cast_to = (targetPos - targetSight.global_position).normalized() * distanceToTarget
	
	return !targetSight.is_colliding()
	
	
func exit_state() -> void:
	targetSight.enabled = false
	fsm.exclaimationSprite.visible = false
