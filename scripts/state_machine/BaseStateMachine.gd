extends Node2D
class_name BaseStateMachine

const HISTORY_LIMIT : int = 10

export(NodePath) var animationPlayerPath : NodePath
export(NodePath) var spritePath : NodePath

var state : BaseState
var velocity := Vector2.ZERO

var history := []

var anim : AnimationPlayer
var sprite : Sprite


func ready() -> void:
	if animationPlayerPath:
		anim = get_node(animationPlayerPath)
		
	if spritePath:
		sprite = get_node(spritePath)
	
	if anim:
		anim.connect("animation_finished", self, "_on_FSM_Anim_animation_finished")
	
	state = get_child(0)
	state.fsm = self
	state.isActiveState = true
	state.enter_state()
	
	
func revert_state() -> void:
	change_state(history[history.size() - 1])
	
	
func change_state(newStateName : String, params : Dictionary = {}) -> void:
	update_history(newStateName)
	state.exit_state()
	state.isActiveState = false
	state = get_node(newStateName)
	state.fsm = self
	state.isActiveState = true
	state.enter_state(params)
	
	
func update_history(_stateName : String) -> void:
	if history.size() > HISTORY_LIMIT:
		history.pop_front()
		
	history.append(state.name)
	
	
func _on_FSM_Anim_animation_finished(anim_name)  -> void:
	state.animation_finished(anim_name)
