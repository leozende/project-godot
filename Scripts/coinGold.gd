extends Area

func _on_coinGold_body_entered(body):
	print("O player colidiu")
	$anim.play("Collect")
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
