extends PlayerState

const WIND_UP_ITEM_POS := Vector2(-8, -6)

export(NodePath) var aimerPath

var aimer : Aimer
var throwAnim : String = "throw"

onready var timer = $Timer as Timer


func _ready() -> void:
	aimer = get_node(aimerPath)


func enter_state(params : Dictionary = {}) -> void:
	if params.keys().has("isCrouched") && params.isCrouched:
		fsm.anim.play("crouch_wind_up")
		throwAnim = "crouch_throw"
	else:
		fsm.anim.play("wind_up")
		throwAnim = "throw"
	
	timer.start()
	fsm.heldItemPos.position.x *= -1 if fsm.sprite.flip_h else 1
	aimer.visible = true
	
	
func input(event) -> void:
	if event.is_action_released("throw"):
		var throwDir = (aimer.sprite.global_position - aimer.global_position).normalized()
		fsm.change_state("Throw", { "throwDir" : throwDir, "scale" : calculateThrowScale(), "throwAnim" : throwAnim })
		
	if event.is_action_pressed("move_right"):
		handleFacing(1)
		faceWindUp()
		
	if event.is_action_pressed("move_left"):
		handleFacing(-1)
		faceWindUp()
		
	if event.is_action_pressed("crouch"):
		fsm.anim.play("crouch_wind_up")
		throwAnim = "crouch_throw"
	elif event.is_action_released("crouch"):
		fsm.anim.play("wind_up")
		throwAnim = "throw"
		
		
func process(delta : float) -> void:
	if !timer.is_stopped():
		var xCoord = range_lerp(timer.time_left, 0.0, timer.wait_time, aimer.AIM_OFFSET_MAX, aimer.AIM_OFFSET_MIN)
		aimer.setSpritePos(Vector2(xCoord, 0.0))
		
	var aimerFacing = sign(aimer.sprite.global_position.x - aimer.global_position.x)
	if aimerFacing != 0:
		handleFacing(aimerFacing)
		faceWindUp()
		
		
func physics_process(delta : float) -> void:
	if fsm.velocity.x != 0:
		fsm.velocity.x = lerp(fsm.velocity.x, 0.0, FRICTION)
		if abs(fsm.velocity.x) < LERP_THRESHOLD:
			fsm.velocity.x = 0
			
			
func faceWindUp() -> void:
	fsm.heldItemPos.position = WIND_UP_ITEM_POS
	fsm.heldItemPos.position.x *= -1 if fsm.sprite.flip_h else 1
	
	
func calculateThrowScale() -> float:
	return 1.0 + range_lerp(aimer.sprite.position.x, aimer.AIM_OFFSET_MIN, aimer.AIM_OFFSET_MAX, 0.0, 0.75)
	
	
func exit_state() -> void:
	aimer.visible = false
