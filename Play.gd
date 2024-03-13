extends RigidBody3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_UP):
		apply_central_force(Vector3(0, 3000 * delta, 0))
	


func _on_body_entered(body: Node) -> void:
	print(body.name)
