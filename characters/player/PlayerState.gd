extends BaseState
class_name PlayerState

const HELD_ITEM_POS := Vector2(-3, -8)

const FRICTION := 0.4
const AIR_FRICTION := 0.05
const MOVE_SPEED := 75.0
const CROUCH_SPEED := 30.0
const JUMP_FORCE := -200.0
const AIR_MOVE_SPEED := 60.0
const GRAVITY := 10.0
const LERP_THRESHOLD := 0.01

var fsm : PlayerStateMachine
