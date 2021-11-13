extends KinematicBody2D

const GRAVITY := 6.0
const FRICTION := 0.2
const AIR_FRICTION := 0.05
const THROW_SPEED_UP := -80.0
const THROW_SPEED_FORWARD := 100.0
const MOVE_THRESHOLD := 0.01

var velocity = Vector2.ZERO

onready var sprite = $Sprite as Sprite
onready var pickUpDetect = $PickUpDetect as Area2D
onready var enableDetectDelay = $EnableDetectDelay as Timer


func _ready() -> void:
	set_physics_process(false)


func _physics_process(delta : float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY
		velocity.x = lerp(velocity.x, 0.0, AIR_FRICTION)
	else:
		velocity.y = GRAVITY
		velocity.x = lerp(velocity.x, 0.0, FRICTION)
		
	move_and_slide(velocity, Vector2.UP)
	
	if abs(velocity.x) < MOVE_THRESHOLD:
		velocity.x = 0.0
	
	
func throw() -> void:
	var throwDir = -1 if sprite.flip_h else 1
	velocity = Vector2(THROW_SPEED_FORWARD * throwDir, THROW_SPEED_UP)
	call_deferred("set_physics_process", true)
	enableDetectDelay.start()


func highlight(enable : bool = true) -> void:
	sprite.frame = 1 if enable else 0
	
	
func enableDetect() -> void:
	pickUpDetect.monitoring = true
	
	
func disableDetect() -> void:
	pickUpDetect.monitoring = false


func _on_PickUpDetect_body_entered(body : Player) -> void:
	if !body: 
		return
		
	body.addPickUpItem(self)


func _on_PickUpDetect_body_exited(body : Player) -> void:
	if !body:
		return
		
	body.removePickUpItem(self)
	highlight(false)


func _on_EnableDetectDelay_timeout() -> void:
	enableDetect()
