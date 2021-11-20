extends KinematicBody2D
class_name Player

const SIGHT_DETECT_STAND : = Vector2(0, -6)
const SIGHT_DETECT_CROUCH : = Vector2.ZERO

var pickupItems : Dictionary = {}
var closestItem = null
var heldItem = null

var isCrouched : bool = false

onready var sprite = $Sprite as Sprite
onready var stateWrap = $PlayerStateMachine as PlayerStateMachine
onready var sightDetect = $SightDetect as Area2D


func _ready() -> void:
	stateWrap.ready()
	stateWrap.velocity = Vector2(0, stateWrap.state.GRAVITY)


func _input(event) -> void:
	if event.is_action_pressed("interact"):
		dropItem()
		pickUpItem()
	
	stateWrap.state.input(event)
	
	
func _unhandled_input(event) -> void:
	stateWrap.state.unhandled_input(event)
	
	
func _process(delta) -> void:
	if heldItem && is_instance_valid(heldItem):
		heldItem.global_position = stateWrap.state.heldItemPos.global_position
	
	stateWrap.state.process(delta)


func _physics_process(delta) -> void:
	stateWrap.state.physics_process(delta)
	move_and_slide(stateWrap.velocity, Vector2.UP)
	stateWrap.isOnFloor = is_on_floor()
	stateWrap.isOnCeiling = is_on_ceiling()
	
	for index in get_slide_count():
		stateWrap.state.handle_collision(get_slide_collision(index))
		
		
func setIsCrouched(val : bool) -> void:
	isCrouched = val
		
		
func turnAround() -> void:
	sprite.flip_h = stateWrap.velocity.x < 0
	flipHeldItemPos()
	flipHeldItem()
	
	
func flipHeldItemPos() -> void:
	if (sprite.flip_h && stateWrap.state.heldItemPos.position.x < 0) || (!sprite.flip_h && stateWrap.state.heldItemPos.position.x > 0):
		stateWrap.state.heldItemPos.position.x *= -1
		

func flipHeldItem() -> void:
	if heldItem && is_instance_valid(heldItem):
		heldItem.sprite.flip_h = sprite.flip_h
		
		
func addPickUpItem(item) -> void:
	pickupItems[item.get_instance_id()] = item
	findClosestItem()
	
	
func removePickUpItem(item) -> void:
	pickupItems.erase(item.get_instance_id())
	findClosestItem()
	
	
func findClosestItem() -> void:
	closestItem = null
	for item in pickupItems.values():
		if item != heldItem:
			if closestItem == null:
				closestItem = item
			else:
				if global_position.distance_to(item.global_position) < global_position.distance_to(closestItem.global_position):
					closestItem.highlight(false)
					closestItem = item
				
	if closestItem:
		closestItem.highlight()
		
		
func pickUpItem() -> void:
	if closestItem:
		heldItem = closestItem
		heldItem.isHeld = true
		heldItem.highlight(false)
		heldItem.disableDetect()
		closestItem = null
		flipHeldItemPos()
		flipHeldItem()
		
	
func dropItem() -> void:
	if heldItem:
		heldItem.isHeld = false
		var facing = -1 if sprite.flip_h else 1
		heldItem.throw(Vector2(facing, 1.0).normalized(), 0.5)
		heldItem.isThrown = false
		heldItem = null
