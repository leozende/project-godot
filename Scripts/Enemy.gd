extends KinematicBody

var enemyHP := 3
var damage := 1

var attackDistance := 1.0
var attackRate := 1.0
var enemySpeed := 2.5

var velocity := Vector3.ZERO

onready var timer := $attackTimer as Timer
onready var player := get_node("/root/World/Character")

const UP = Vector3.UP

func _ready():
	timer.wait_time = attackRate
	timer.start()
	
func _physics_process(delta):
	var distance = translation.distance_to(player.translation)
	
	if distance > attackDistance:
		var direction = (player.translation - translation).normalized()
		
		velocity = Vector3(direction.x, 0, direction.z)
		
		velocity = move_and_slide(velocity,UP)
		
func take_damage(damage):
	enemyHP -= damage
	
	if enemyHP <= 0:
		queue_free()


func _on_attackTimer_timeout():
	if translation.distance_to(player.translation) <= attackDistance:
		player.take_damage(damage)
