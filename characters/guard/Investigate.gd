extends GuardState

const NEARBY_THRESHOLD := 8.0

var noisePos : Vector2
var moveDir

onready var wallDetect = $WallDetect as RayCast2D
onready var edgeDetect = $EdgeDetect as RayCast2D


func enter_state(params : Dictionary = {}) -> void:
	print('investigate')
	wallDetect.enabled = true
	edgeDetect.enabled = true
	fsm.questionSprite.visible = true
	fsm.anim.play("run", -1, 0.5)
	noisePos = params.noisePosition
	moveDir = sign(noisePos.x - global_position.x)
	handleFacing(moveDir)
	
	
func physics_process(delta : float) -> void:
	fsm.velocity.x = moveDir * PATROL_SPEED
	
	if abs(noisePos.x - global_position.x) < NEARBY_THRESHOLD:
		fsm.change_state("Search", { "noisePosition": noisePos })
		return
		
	if wallDetect.is_colliding():
		fsm.change_state("Search", { "noisePosition": wallDetect.get_collision_point() })
		return
	elif edgeDetect.is_colliding():
		fsm.change_state("Search", { "noisePosition": edgeDetect.get_collision_point() })
		return
		
		
func handleFacing(facingDir : int) -> void:
	.handleFacing(facingDir)
	edgeDetect.position.x = facingDir * EDGE_DETECT_OFFSET
	wallDetect.cast_to.x = facingDir * WALL_DETECT_DISTANCE
	
	
func exit_state() -> void:
	wallDetect.enabled = false
	edgeDetect.enabled = false
