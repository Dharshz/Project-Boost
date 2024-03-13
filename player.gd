extends RigidBody3D

@export_range(750, 3000) var thurst: float = 1000

@export_range(-500, 500) var torque_thurst: float = 300

@onready var explosion_audio: AudioStreamPlayer = $ExplosionAudio
@onready var success_audio: AudioStreamPlayer = $SuccessAudio
@onready var rocket_audio: AudioStreamPlayer = $RocketAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles


var is_transitioning: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		apply_central_force(basis.y * delta * thurst)
		if rocket_audio.playing == false:
			rocket_audio.play()
		booster_particles.emitting = true
	else:
		rocket_audio.stop()
		booster_particles.emitting = false
		
	if Input.is_action_pressed("ui_left"):
		apply_torque(Vector3(0, 0, torque_thurst * delta))
	
	if Input.is_action_pressed("ui_right"):
		apply_torque(Vector3(0, 0, -torque_thurst * delta))


func _on_body_entered(body: Node) -> void:
	if is_transitioning == false:
		if "Goal" in body.get_groups():
			on_complete(body.file_path)
		if "@onready var rocket_audio: AudioStreamPlayer = $RocketAudio
" in body.get_groups():
			on_crash()

func on_complete(path):
	set_process(false)
	success_audio.play()
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().change_scene_to_file.bind(path))
	
func on_crash():
	set_process(false)
	explosion_audio.play()
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().reload_current_scene)
