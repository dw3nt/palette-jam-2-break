extends WallBlock


func _on_KeyDetect_body_entered(body : Key) -> void:
	if !body:
		return
		
	if !body.isHeld:
		queue_free()
		body.queue_free()


func _on_KeyDetect_area_entered(area) -> void:
	var body = area.get_parent()
	if !body.isHeld:
		queue_free()
		body.queue_free()
