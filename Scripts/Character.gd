extends KinematicBody

var velocity := Vector3.ZERO
var speed := 1
var jump_force := 6

var gravity := Vector3.DOWN * 12
var mouse_rotation := 0.05

func _physics_process(delta):
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
func get_input():
	if Input.is_action_pressed("move_forward"):
		velocity.z -= speed
	if Input.is_action_pressed("move_backward"):
		velocity.z += speed
