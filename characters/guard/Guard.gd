extends KinematicBody2D

onready var hearingDetect = $HearingDetect
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
	
	
func detectedSound(sound : Sound) -> void:
	var firstIteration = true
	var remainingDistance = sound.magnitude
	var worldSpace = get_world_2d().direct_space_state
	var startPos = sound.global_position
	var endPos = hearingDetect.global_position
	var excludes = []
	while remainingDistance > 0.0:
		var intersection = worldSpace.intersect_ray(startPos, endPos, excludes, 272, true, true)
		if intersection:
			if intersection.collider.is_in_group("block_vision"):
				var distanceTraveled = startPos.distance_to(intersection.position)
				remainingDistance = (remainingDistance - distanceTraveled) / 2.0
				excludes = [intersection.collider]
				startPos = intersection.position
			else:	# ray only looks for wall and guard_listen layers
				remainingDistance = 0.0
				stateWrap.state.heardNoise(sound.position)
			
		firstIteration = false


func _on_HurtDetect_body_entered(body : PickUpItem) -> void:
	if !body:
		return
		
	if body.isThrown:
		stateWrap.change_state("Stun")


func _on_VisionRangeDetect_area_entered(area : Area2D) -> void:
	stateWrap.chaseTarget = area.get_parent()


func _on_VisionRangeDetect_area_exited(area : Area2D) -> void:
	stateWrap.chaseTarget = null
