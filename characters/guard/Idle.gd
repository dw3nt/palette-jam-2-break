extends GuardState

const IDLE_TIME_MIN := 2.5
const IDLE_TIME_MAX := 6.0

var idleTime : float

onready var playerDetect = $PlayerDetect as RayCast2D
onready var timer = $Timer as Timer


func _ready() -> void:
	idleTime = rand_range(IDLE_TIME_MIN, IDLE_TIME_MAX)


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("idle")
	timer.start(idleTime)
	
	playerDetect.enabled = true
	playerDetect.cast_to.x = -PLAYER_DETECT_DISTANCE if fsm.sprite.flip_h else PLAYER_DETECT_DISTANCE
	
	
func physics_process(delta : float) -> void:
	if !fsm.isOnFloor:
		fsm.change_state("Fall")
		return
	
	slideToHalt()
	
	if playerDetect.is_colliding() && playerDetect.get_collider() is Player:
		fsm.change_state("Alert", { "target" : playerDetect.get_collider() })


func _on_Timer_timeout() -> void:
	fsm.change_state("Patrol", { "moveDir" : 1 if randf() < 0.5 else -1 })
	
	
func exit_state() -> void:
	timer.stop()
	playerDetect.enabled = false
