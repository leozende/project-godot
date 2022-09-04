extends KinematicBody

var velocity := Vector3.ZERO
var speed := 5
var jump_force := 6

var gravity := Vector3.DOWN * 12
var mouse_rotation := 0.05

var is_jumping := false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	velocity += gravity * delta
	
	move_input(delta)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jumping = true
		velocity.y += jump_force
	else:
		is_jumping = false
	
	var snap_vector = Vector3.DOWN if not is_jumping else Vector3.ZERO
	
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector3.UP, true, 4, deg2rad(70))
	
func move_input(delta):
	var input = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		input -= transform.basis.z * speed
	if Input.is_action_pressed("move_backward"):
		input += transform.basis.z * speed
	if Input.is_action_pressed("move_left"):
		input -= transform.basis.x * speed
	if Input.is_action_pressed("move_right"):
		input += transform.basis.x * speed
	
	velocity.x = input.x
	velocity.z = input.z
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-lerp(0, mouse_rotation, event.relative.x / 10))
		
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_just_pressed("ui_accept") and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
