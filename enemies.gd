extends Area2D

@export var speed = 50
@export var hp = 10
@export var gold_drop = 1
var stopped = false


func _ready():
	hp = hp - (GameData.enemy_hp_upgrade * 2)
	speed = speed - (GameData.enemy_speed_upgrade * 2)
	speed = speed + (GameData.enemy_power * .5)
	hp = hp + (GameData.enemy_power * 0.1)
	hp = max(hp, 1)
	speed = max(speed, 15)
	print("enemy spawned at: ", global_position)

func _process(delta):
	if not stopped:
		position.x -= speed * delta
	
func take_damage(amount):
	hp -= amount
	if hp <=0:
		speed += .5
		GameData.gold += gold_drop
		GameData.enemy_power += 1
		get_parent().get_node("Felix2D").update_ui()
		if name.begins_with("Gremlin") or gold_drop == 8:
			get_parent().get_node("Felix2D").you_win()
		queue_free()
