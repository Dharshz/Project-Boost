extends AnimatableBody3D

@export var destination: Vector3
@export var duration: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var t = create_tween()
	t.set_loops()
	t.set_trans(Tween.TRANS_SINE)
	t.tween_property(self, "global_position", global_position + destination, duration)
	t.tween_property(self, "global_position", global_position, duration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
