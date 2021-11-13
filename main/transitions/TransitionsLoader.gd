extends Node

enum Transitions { FadeInOut, SwipeToMiddle }

var transitionsMap = [
	"FadeInOut",
	"SwipeToMiddle"
]


func initTransitions(parentNode):
	for index in range(transitionsMap.size()):
		var inst = load("res://main/transitions/" + transitionsMap[index] + ".tscn").instance()
		inst.visible = false
		parentNode.add_child(inst)
