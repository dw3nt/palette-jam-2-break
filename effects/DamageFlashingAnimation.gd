extends AnimationPlayer
class_name DamageAnimationPlayer

export (int) var flashAmountsMax = 3
export (float) var speedScale = 1.0

var flashAmounts = 0


func playAnim() -> void:
	play("damaged", -1, speedScale)
	flashAmounts = 0


func updateFlashAmount() -> void:
	flashAmounts += 1
	if flashAmounts < flashAmountsMax:
		play("damaged")
	else:
		flashAmounts = 0
