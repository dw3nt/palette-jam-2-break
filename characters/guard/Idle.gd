extends GuardState

const IDLE_TIME_MIN := 2.5
const IDLE_TIME_MAX := 6.0

var idleTime : float

onready var timer = $Timer as Timer


func _ready() -> void:
	idleTime = rand_range(IDLE_TIME_MIN, IDLE_TIME_MAX)


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("idle")
	timer.start(idleTime)
	
	
func physics_process(delta : float) -> void:
	if fsm.velocity.x != 0:
		fsm.velocity.x = lerp(fsm.velocity.x, 0.0, FRICTION)
		if abs(fsm.velocity.x) < LERP_THRESHOLD:
			fsm.velocity.x = 0


func _on_Timer_timeout() -> void:
	fsm.change_state("Patrol", { "moveDir" : 1 if randf() < 0.5 else -1 })
