extends CharacterBody2D

signal died(xpValue)

var health = 5
var xpValue = 33
var damage_multiplier = 1 

@onready var player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()

	player.level_up.connect(Callable(self, "_on_level_changed"))
	

func _on_level_changed(level):
	damage_multiplier = 1.0 + (level)
	print(str(damage_multiplier))
	

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()
	

func take_damage():
	health -= damage_multiplier
	#print("dmg " + str(damage_multiplier))
	#print("heal" + str(health))
	%Slime.play_hurt()
	 
	if health <= 0:
		
		died.emit(xpValue)
		#print("Pouf! " + str(xpValue))
		queue_free()
	
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
		
		
