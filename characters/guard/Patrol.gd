extends GuardState

const WALL_DETECT_DISTANCE := 6
const EDGE_DETECT_OFFSET := 5
const PATROL_TIME_MIN := 2.0
const PATROL_TIME_MAX := 4.0

var patrolTime : float
var moveDir : int = 1
var shouldTurnAround : bool = true

onready var timer = $Timer as Timer
onready var wallDetect = $WallDetect as RayCast2D
onready var edgeDetect = $EdgeDetect as RayCast2D
onready var edgeTimer = $EdgeDetect/EdgeTimer as Timer


func _ready() -> void:
	patrolTime = rand_range(PATROL_TIME_MIN, PATROL_TIME_MAX)


func enter_state(params : Dictionary = {}) -> void:
	if params.keys().has("moveDir") && params.moveDir:
		moveDir = params.moveDir
	
	fsm.anim.play("run", -1, 0.5)
	timer.start(patrolTime)
	edgeTimer.start()
	
	shouldTurnAround = true
	edgeDetect.enabled = true
	wallDetect.enabled = true
	handleFacing(moveDir)


func physics_process(delta : float) -> void:
	if edgeDetect.is_colliding():
		if shouldTurnAround:
			moveDir *= -1
			handleFacing(moveDir)
		else:
			timer.stop()
			fsm.change_state("Idle")
			return
	elif wallDetect.is_colliding():
		moveDir *= -1
		handleFacing(moveDir)
	
	fsm.velocity.x = moveDir * PATROL_SPEED
	
	
func exit_state() -> void:
	edgeDetect.enabled = false
	wallDetect.enabled = false
	
	
func handleFacing(facingDir : int) -> void:
	.handleFacing(facingDir)
	edgeDetect.position.x = facingDir * EDGE_DETECT_OFFSET
	wallDetect.cast_to.x = facingDir * WALL_DETECT_DISTANCE


func _on_Timer_timeout() -> void:
	fsm.change_state("Idle")


func _on_EdgeTimer_timeout() -> void:
	shouldTurnAround = false
