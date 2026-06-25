extends Node2D

@export var enemy_scene: PackedScene
var spawn_timer = 0.0
var spawn_interval = 2.0
var can_spawn = false

func _process(delta):
	if not can_spawn:
		return
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(655, 177)
	print(enemy.position, " | parent: ", get_parent().name)
	print("spawn enemy")
	get_parent().add_child(enemy)
	
