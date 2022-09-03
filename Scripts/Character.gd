extends KinematicBody

var velocity := Vector3.ZERO
var speed := 5
var jump_force := 6

var gravity := Vector3.DOWN * 12
var mouse_rotation := 0.05

var is_jumping := false

func _physics_process(delta):
	velocity += gravity * delta
	
	if is_jumping:
		velocity.y += jump_force
	
	move_input()
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
func move_input():
	var velocity_y = velocity.y
	
	velocity = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		velocity -= transform.basis.z * speed
	if Input.is_action_pressed("move_backward"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("move_left"):
		velocity -= transform.basis.x * speed
	if Input.is_action_pressed("move_right"):
		velocity += transform.basis.x * speed
	
	velocity.y = velocity_y
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jumping = true
	else:
		is_jumping = false
		
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-lerp(0, mouse_rotation, event.relative.x / 10))
