extends Node2D
class_name Aimer

const DEADZONE := 0.2
const AIM_OFFSET_MIN := 8
const AIM_OFFSET_MAX := 32

var isController : bool = false
var deviceId : int = 0

onready var sprite = $Sprite as Sprite


func _input(event) -> void:
	if event is InputEventKey:
		isController = false
		deviceId = 0
	elif event is InputEventJoypadButton:
		isController = true
		deviceId = event.device


func _process(delta : float) -> void:
	if !isController:
		look_at(get_global_mouse_position())
	else:
		look_at(global_position + Vector2(
			Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left"),
			Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
		).normalized())
		
	sprite.rotation = -rotation
	
	
func setSpritePos(pos : Vector2) -> void:
	sprite.position = pos
