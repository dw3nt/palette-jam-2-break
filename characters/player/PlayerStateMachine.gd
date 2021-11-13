extends BaseStateMachine
class_name PlayerStateMachine

export(NodePath) var heldItemPositionPath : NodePath

var heldItemPos : Position2D
var isOnFloor : bool


func ready() -> void:
	if heldItemPositionPath:
		heldItemPos = get_node(heldItemPositionPath)
		
	.ready()


func getHeldItem():
	return get_parent().heldItem
