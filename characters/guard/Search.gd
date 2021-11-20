extends GuardState

const SEARCH_TIME_MIN := 0.5
const SEARCH_TIME_MAX := 2.5
const SEARCH_DISTANCE := 12.0

const TOTAL_SEARCH_TIME_MIN := 5.0
const TOTAL_SEARCH_TIME_MAX := 6.5

var noisePos : Vector2
var moveDir := 0

onready var wallDetect = $WallDetect as RayCast2D
onready var edgeDetect = $EdgeDetect as RayCast2D
onready var searchTimer = $SearchTime as Timer
onready var giveUpTimer = $GiveUpTimer as Timer


func enter_state(params : Dictionary = {}) -> void:
	print('search')
	wallDetect.enabled = true
	edgeDetect.enabled = true
	fsm.anim.play("idle")
	noisePos = params.noisePosition
	searchTimer.start(rand_range(SEARCH_TIME_MIN, SEARCH_TIME_MAX))
	giveUpTimer.start(rand_range(TOTAL_SEARCH_TIME_MIN, TOTAL_SEARCH_TIME_MAX))
	handleFacing(moveDir)
	
	
func physics_process(delta : float) -> void:	
	if moveDir != 0:
		if edgeDetect.is_colliding() || wallDetect.is_colliding():
			moveDir *= -1
			handleFacing(moveDir)
		
		fsm.velocity.x = moveDir * PATROL_SPEED
	else:
		slideToHalt()
		
		
func chooseMoveDir() -> void:
	if abs(global_position.x - noisePos.x) > SEARCH_DISTANCE:
		moveDir = sign(noisePos.x - global_position.x)
	else:
		moveDir = -1 if randf() < 0.5 else 1
		
	handleFacing(moveDir)
	
	
func handleFacing(facingDir : int) -> void:
	if facingDir == 0:
		facingDir = -1 if fsm.sprite.flip_h else 1
	
	.handleFacing(facingDir)
	edgeDetect.position.x = facingDir * EDGE_DETECT_OFFSET
	wallDetect.cast_to.x = facingDir * WALL_DETECT_DISTANCE


func _on_SearchTime_timeout() -> void:
	if moveDir == 0:
		fsm.anim.play("run", -1, 0.5)
		chooseMoveDir()
	else:
		fsm.anim.play("idle")
		moveDir = 0
		
	searchTimer.start(rand_range(SEARCH_TIME_MIN, SEARCH_TIME_MAX))


func _on_GiveUpTimer_timeout() -> void:
	fsm.change_state("Idle")
	
	
func exit_state() -> void:
	fsm.questionSprite.visible = false
	wallDetect.enabled = false
	edgeDetect.enabled = false
