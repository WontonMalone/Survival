extends Node2D

@onready var game_over_screen = $"../UI/GameOverScreen"

@export var hp = 20




func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shoot()

func shoot():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collision_mask = 1
	var results = space_state.intersect_point(query)
	print("results: ", results)
	
	for result in results:
		if result.collider.is_in_group("enemies"):
			result.collider.take_damage(5)

func take_damage(amount):
	hp -= amount
	print("Felix hp: ", hp)
	if hp <= 0:
		get_tree().paused = true
		game_over_screen.visible = true
		print("Game Over")


func _on_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
