extends GuardState

const IDLE_TIME_MIN := 2.5
const IDLE_TIME_MAX := 6.0

var idleTime : float
var standSoundTarget : Player
var crouchSoundTarget : Player

onready var timer = $Timer as Timer


func _ready() -> void:
	idleTime = rand_range(IDLE_TIME_MIN, IDLE_TIME_MAX)


func enter_state(_params : Dictionary = {}) -> void:
	fsm.anim.play("idle")
	timer.start(idleTime)
	
	
func physics_process(delta : float) -> void:
	if canSeeChaseTarget():
		fsm.change_state("Alert")
		return
	
	if !fsm.isOnFloor:
		fsm.change_state("Fall")
		return
	
	slideToHalt()
	

func heardNoise(position : Vector2) -> void:
	fsm.change_state("Patrol", { "noisePosition" : position })
	

func _on_Timer_timeout() -> void:
	fsm.change_state("Patrol", { "moveDir" : 1 if randf() < 0.5 else -1 })
	
	
func exit_state() -> void:
	timer.stop()


func _on_StandSoundDetect_body_entered(body : Player) -> void:
	if !body:
		return
		
	standSoundTarget = body


func _on_StandSoundDetect_body_exited(body : Player) -> void:
	if !body:
		return
		
	standSoundTarget = null


func _on_CrouchSoundDetect_body_entered(body : Player) -> void:
	if !body:
		return
		
	crouchSoundTarget = body


func _on_CrouchSoundDetect_body_exited(body : Player) -> void:
	if !body:
		return
		
	crouchSoundTarget = null
