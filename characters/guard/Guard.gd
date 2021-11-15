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
