extends BaseStateMachine
class_name GuardStateMachine

export(NodePath) var exclaimationSpritePath
export(NodePath) var stunSparksSpritePath

var exclaimationSprite
var stunSparkSprite

var isOnFloor : bool


func ready() -> void:
	.ready()
	exclaimationSprite = get_node(exclaimationSpritePath)
	stunSparkSprite = get_node(stunSparksSpritePath)
