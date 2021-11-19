extends KinematicBody2D

onready var stateWrap = $GuardStateMachine as GuardStateMachine


func _ready() -> void:
	stateWrap.ready()
	stateWrap.velocity = Vector2(0, stateWrap.state.GRAVITY)


func _input(event) -> void:
	stateWrap.state.input(event)
	
	
func _unhandled_input(event) -> void:
	stateWrap.state.unhandled_input(event)
	
	
func _process(delta) -> void:
	stateWrap.state.process(delta)


func _physics_process(delta) -> void:
	stateWrap.state.physics_process(delta)
	move_and_slide(stateWrap.velocity, Vector2.UP)
	stateWrap.isOnFloor = is_on_floor()


func _on_HurtDetect_body_entered(body : PickUpItem) -> void:
	if !body:
		return
		
	if body.isThrown:
		stateWrap.change_state("Stun")


func _on_VisionRangeDetect_area_entered(area : Area2D) -> void:
	stateWrap.chaseTarget = area.get_parent()


func _on_VisionRangeDetect_area_exited(area : Area2D) -> void:
	stateWrap.chaseTarget = null
	
