extends BaseState
class_name GuardState

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
