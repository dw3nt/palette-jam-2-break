extends StaticBody2D


func _on_KeyDetect_body_entered(body : Key) -> void:
	if !body:
		return
		
	queue_free()
	body.queue_free()
