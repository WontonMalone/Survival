extends Node2D

@export var worm_scene: PackedScene
@export var fly_scene: PackedScene
@export var goo_scene: PackedScene
@export var gremlin_scene: PackedScene

var spawn_timer = 0.0
var spawn_interval = 2.0
var can_spawn = false
var game_timer = 0.0

func _process(delta):
	if not can_spawn:
		return
	game_timer += delta
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()

func spawn_enemy():
	var enemy
	if game_timer < 30:
		enemy = worm_scene.instantiate()
	elif game_timer < 60:
		enemy = fly_scene.instantiate()
	elif game_timer < 120:
		enemy = goo_scene.instantiate()
	else:
		enemy = gremlin_scene.instantiate()
	enemy.position = Vector2(655, 177)
	print(enemy.position, " | parent: ", get_parent().name)
	print("spawn enemy")
	get_parent().add_child(enemy)
	
