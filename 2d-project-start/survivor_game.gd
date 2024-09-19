extends Node2D

@onready var  kill_count_label =  %KillCountLabel

var killCount = 0
var totalExp = 0




func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
	var player_node = get_node("/root/Game/Player")
	
	
	new_mob.died.connect(Callable(player_node,"_on_monster_died"))
	new_mob.died.connect(Callable(self,"_on_mob_died"))
	


func _on_timer_timeout():
	spawn_mob()
	


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true
	
func _on_mob_died(xpValue):
	killCount += 1
	totalExp += xpValue
	print("killCount: " + str(killCount))
	print("totalExp: " + str(totalExp))
	update_label()
	
func update_label():
	kill_count_label.text = "KillCount: " + str(killCount)  	
	
