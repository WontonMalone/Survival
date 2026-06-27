extends Node2D

@export var worm_scene: PackedScene
@export var fly_scene: PackedScene
@export var goo_scene: PackedScene
@export var gremlin_scene: PackedScene

var spawn_timer = 0.0
var spawn_interval = 2.0
var can_spawn = false
var game_timer = 0.0
var gremlin_spawned = false

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
		var roll = randi() % 2
		if roll == 0:
			enemy = worm_scene.instantiate()
		else:
			enemy = fly_scene.instantiate()
	elif game_timer < 120:
		var roll = randi() % 3
		if roll == 0:
			enemy = worm_scene.instantiate()
		elif roll == 1:
			enemy = fly_scene.instantiate()
		else:
			enemy = goo_scene.instantiate()
	else:
		var roll = randi() % 3
		if roll == 0:
			enemy = worm_scene.instantiate()
		elif roll == 1:
			enemy = fly_scene.instantiate()
		else:
			enemy = goo_scene.instantiate()
		if not gremlin_spawned:
			gremlin_spawned = true
			var gremlin = gremlin_scene.instantiate()
			gremlin.position = Vector2(655, 177)
			get_parent().add_child(gremlin)
	enemy.position = Vector2(675, 153)
	print(enemy.position, " | parent: ", get_parent().name)
	print("spawn enemy")
	get_parent().add_child(enemy)
	
