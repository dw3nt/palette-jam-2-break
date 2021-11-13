extends Node2D
class_name BaseState

var isActiveState = false


func enter_state(_params : Dictionary = {}) -> void:
	isActiveState = true
	
	
func process(_delta : float) -> void:
	pass
	
	
func physics_process(_delta : float) -> void:
	pass
	
	
func handle_collision(_collision : KinematicCollision2D) -> void:
	pass
	
	
func input(_event)  -> void:
	pass
	
	
func unhandled_input(_event) -> void:
	pass
	
	
func animation_finished(_anim_name)  -> void:
	pass
	
	
func exit_state()  -> void:
	isActiveState = false
