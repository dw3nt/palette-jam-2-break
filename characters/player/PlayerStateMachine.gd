extends BaseStateMachine
class_name PlayerStateMachine

export(NodePath) var heldItemPositionPath : NodePath

var heldItemPos : Position2D
var isOnFloor : bool


func ready() -> void:
	if heldItemPositionPath:
		heldItemPos = get_node(heldItemPositionPath)
		
	.ready()
	
	
func change_state(newStateName : String, params : Dictionary = {}) -> void:
	.change_state(newStateName, params)
	
	for collider in get_tree().get_nodes_in_group("player_collision"):
		collider.disabled = true
		
	state.collider.disabled = false	


func getHeldItem():
	return get_parent().heldItem
