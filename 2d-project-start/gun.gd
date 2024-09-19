extends Area2D

func _physics_process(delta):
	#return an array
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
	
func shoot():
	
	#all of the this is the same as dragging the bullet on the gun at the shooting point
	#but dynamically
	const BULLET = preload("res://bullet.tscn")
	#function on loaded scene to create that scene
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	#match the shooting point
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
	


func _on_timer_timeout():
	shoot()
