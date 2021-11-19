extends BaseStateMachine
class_name GuardStateMachine

export(NodePath) var exclaimationSpritePath
export(NodePath) var questionSpritePath
export(NodePath) var stunSparksSpritePath
export(NodePath) var lineOfSightPosPath

var exclaimationSprite : Sprite
var questionSprite : Sprite
var stunSparkSprite : AnimatedSprite
var lineOfSightPos : Position2D

var chaseTarget : Player

var isOnFloor : bool


func ready() -> void:
	.ready()
	exclaimationSprite = get_node(exclaimationSpritePath)
	questionSprite = get_node(questionSpritePath)
	stunSparkSprite = get_node(stunSparksSpritePath)
	lineOfSightPos = get_node(lineOfSightPosPath)
