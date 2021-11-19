extends Area2D
class_name Sound

export(float) var magnitude := 16.0

onready var collisionShape = $CollisionShape2D


func _ready() -> void:
	initCollision()
	
	
func initCollision() -> void:
	var circleShape = CircleShape2D.new()
	circleShape.radius = magnitude
	collisionShape.shape = circleShape


func _on_Sound_area_entered(area) -> void:
	area.get_parent().detectedSound(self)


func _on_Lifetime_timeout() -> void:
	queue_free()
