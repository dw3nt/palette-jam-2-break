extends PickUpItem
class_name Key

var floatRanges := [-1.0, 1.0]
var initialPos := Vector2.ZERO

onready var tween = $Tween as Tween


func _ready() -> void:
	initialPos = global_position
	startTween()
	
	
func startTween() -> void:
	tween.interpolate_property(self, "position:y", floatRanges[0] + initialPos.y, floatRanges[1] + initialPos.y, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_all_completed() -> void:
	floatRanges.invert()
	startTween()
	
	
func disableDetect() -> void:
	.disableDetect()
	tween.stop_all()


func _on_LockDetect_area_entered(area) -> void:
	shouldMakeNoise = false
