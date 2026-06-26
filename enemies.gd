extends Area2D

@export var speed = 50
@export var hp = 10
@export var gold_drop = 1
var stopped = false

func _ready():
	hp = hp - (GameData.enemy_hp_upgrade * 2)
	speed = speed - (GameData.enemy_speed_upgrade * 5)
	print("enemy spawned at: ", global_position)

func _process(delta):
	if not stopped:
		position.x -= speed * delta
	
func take_damage(amount):
	hp -= amount
	if hp <=0:
		GameData.gold += gold_drop
		get_parent().get_node("Felix2D").update_ui()
		queue_free()
