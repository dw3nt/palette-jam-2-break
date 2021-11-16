extends KinematicBody2D
class_name PickUpItem

const THROW_MAGNITUDE_THRESHOLD := 10.0
const COLLIDER_Y_DIFF := 25.0
const GRAVITY := 6.0
const FRICTION := 0.1
const AIR_FRICTION := 0.05
const THROW_FORCE := 150.0
const MOVE_THRESHOLD := 0.05

var velocity = Vector2.ZERO
var isThrown : bool = false
var isHeld : bool = false

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
		
	if is_on_ceiling():
		velocity.y = GRAVITY
		
	move_and_slide(velocity, Vector2.UP)
	
	if abs(velocity.x) < MOVE_THRESHOLD:
		velocity.x = 0.0
		
	if isThrown && is_on_floor():
		isThrown = false
	
	
func throw(throwDir : Vector2, throwScale : float) -> void:
	velocity = throwDir * THROW_FORCE * throwScale
	isThrown = true
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
