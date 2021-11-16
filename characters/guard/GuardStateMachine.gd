extends BaseStateMachine
class_name GuardStateMachine

export(NodePath) var exclaimationSpritePath

var exclaimationSprite

var isOnFloor : bool


func ready() -> void:
	.ready()
	exclaimationSprite = get_node(exclaimationSpritePath)
