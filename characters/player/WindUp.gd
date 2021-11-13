extends PlayerState

const WIND_UP_ITEM_POS := Vector2(-8, -6)


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("wind_up")
	
	fsm.heldItemPos.position = WIND_UP_ITEM_POS
	fsm.heldItemPos.position.x *= -1 if fsm.sprite.flip_h else 1
	
	
func input(event) -> void:
	if event.is_action_released("throw"):
		fsm.change_state("Throw")
		
	if event.is_action_pressed("move_right"):
		handleFacing(1)
		
	if event.is_action_pressed("move_left"):
		handleFacing(-1)
		
		
func physics_process(delta : float) -> void:
	if fsm.velocity.x != 0:
		fsm.velocity.x = lerp(fsm.velocity.x, 0.0, FRICTION)
		if abs(fsm.velocity.x) < LERP_THRESHOLD:
			fsm.velocity.x = 0
			
			
func handleFacing(dir : int) -> void:
	var oldVelocityX = fsm.velocity.x
	fsm.velocity.x = dir
	fsm.get_parent().turnAround()
	fsm.velocity.x = oldVelocityX
	
	fsm.heldItemPos.position = WIND_UP_ITEM_POS
	fsm.heldItemPos.position.x *= -1 if fsm.sprite.flip_h else 1
