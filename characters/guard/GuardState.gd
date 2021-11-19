extends BaseState
class_name GuardState

const FOV_PROD := 0.3
const FRICTION := 0.4
const AIR_FRICTION := 0.05
const CHASE_SPEED := 40.0
const ALERT_SPEED := 35.0
const PATROL_SPEED := 30.0
const JUMP_FORCE := -40.0
const AIR_MOVE_SPEED := 60.0
const GRAVITY := 10.0
const LERP_THRESHOLD := 0.01
const PLAYER_DETECT_DISTANCE := 50

var fsm : GuardStateMachine


func handleFacing(facingDir : int) -> void:
	fsm.sprite.flip_h = facingDir < 0
	
	
func slideToHalt() -> void:
	if fsm.velocity.x != 0:
		fsm.velocity.x = lerp(fsm.velocity.x, 0.0, FRICTION)
		if abs(fsm.velocity.x) < LERP_THRESHOLD:
			fsm.velocity.x = 0
			
			
func heardNoise(position : Vector2) -> void:
	pass
			
			
func canSeeChaseTarget() -> bool:
	if fsm.chaseTarget:
		var worldSpace = get_world_2d().direct_space_state
		
		var headResult = null
		var midResult = null
		var feetResult = worldSpace.intersect_ray(fsm.lineOfSightPos.global_position, fsm.chaseTarget.global_position, [], 144, true, true)
		if fsm.chaseTarget.isCrouched:
			headResult = worldSpace.intersect_ray(fsm.lineOfSightPos.global_position, fsm.chaseTarget.global_position + Vector2(0, -6), [], 144, true, true)
			midResult = worldSpace.intersect_ray(fsm.lineOfSightPos.global_position, fsm.chaseTarget.global_position + Vector2(0, -2), [], 144, true, true)
		else:
			headResult = worldSpace.intersect_ray(fsm.lineOfSightPos.global_position, fsm.chaseTarget.global_position + Vector2(0, -18), [], 144, true, true)
			midResult = worldSpace.intersect_ray(fsm.lineOfSightPos.global_position, fsm.chaseTarget.global_position + Vector2(0, -5), [], 144, true, true)
		
		var facingVector = Vector2.LEFT if fsm.sprite.flip_h else Vector2.RIGHT
		var chaseTargetDir = (fsm.chaseTarget.global_position - global_position).normalized()
		var dotProd = chaseTargetDir.dot(facingVector)
		
		return dotProd >= FOV_PROD && ( 
			( feetResult && !feetResult.collider.is_in_group("block_vision") ) || 
			( midResult && !midResult.collider.is_in_group("block_vision") ) || 
			( headResult && !headResult.collider.is_in_group("block_vision") )
		) 
		
	return false
