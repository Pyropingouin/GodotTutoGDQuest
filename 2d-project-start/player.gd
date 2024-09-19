extends CharacterBody2D



#custom signal
signal health_depleted
signal level_up(level)

var health = 100.0
var xp = 0
var level = 1


func _process(delta):
	%XpBar.value = xp
	
	if xp >= 100:
		xp = 0
		level += 1
		print("Emitting level_up signal for level: ", level)
		level_up.emit(level)

	
		%XpBar.value = xp
		
		print("Ding level: " + str(level) + " !")
		
	

func _on_monster_died(xpValue):
	xp += xpValue
	#print(str(xp))



	
	
	
#equivalent to update
func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right",
	"move_up","move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else: 	
		%HappyBoo.play_idle_animation()
		
	const DAMAGE_RATE = 20.0
	var overlappping_mobs = %HurtBox.get_overlapping_bodies()
	if overlappping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlappping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			

	
	
