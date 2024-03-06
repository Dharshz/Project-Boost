extends RigidBody3D

@export_range(750, 3000) var thurst: float = 1000

@export_range(-500, 500) var torque_thurst: float = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		apply_central_force(basis.y * delta * thurst)
		
	if Input.is_action_pressed("ui_left"):
		apply_torque(Vector3(0, 0, torque_thurst * delta))
	
	if Input.is_action_pressed("ui_right"):
		apply_torque(Vector3(0, 0, -torque_thurst * delta))


func _on_body_entered(body: Node) -> void:
	if "Goal" in body.get_groups():
		print("win")
	if "Floor" in body.get_groups():
		print("loss")
