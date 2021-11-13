extends Node
class_name RoomVars

var scene : String = ""
var transition : int = 0
var transitionDelay : float = 0.0
var params : Dictionary = {}


func _init(_scene : String, _transition : int = 0, _transitionDelay : float = 0.0, _params : Dictionary = {}) -> void:
	scene = _scene
	transition = _transition
	transitionDelay = _transitionDelay
	params = _params


func getParam(key : String):
	if params.keys().has(key):
		return params[key]
	
	return null
