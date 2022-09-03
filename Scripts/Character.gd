extends KinematicBody

var velocity := Vector3.ZERO
var speed := 5
var jump_force := 6

var gravity := Vector3.DOWN * 12
var mouse_rotation := 0.05

func _physics_process(delta):
	velocity += gravity * delta
	move_input()
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
func move_input():
	velocity.z = 0
	velocity.x = 0
	
	if Input.is_action_pressed("move_forward"):
		velocity.z -= speed
	if Input.is_action_pressed("move_backward"):
		velocity.z += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_just_pressed("jump"):
		velocity.y += jump_force
		
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-lerp(0, mouse_rotation, event.relative.x / 10))
