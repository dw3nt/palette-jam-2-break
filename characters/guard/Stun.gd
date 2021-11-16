extends GuardState

onready var timer = $Timer as Timer


func enter_state(_params : Dictionary = {}):
	timer.start()
	fsm.anim.play("stun")
	fsm.stunSparkSprite.visible = true
	
	
func physics_process(delta : float) -> void:
	slideToHalt()
	
	
func _on_Timer_timeout() -> void:
	fsm.revert_state()
	
	
func exit_state() -> void:
	fsm.stunSparkSprite.visible = false
