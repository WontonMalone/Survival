extends Node2D

var is_spinning = false
var spin_duration = 3.0
var weapons = ["Pistol", "SMG", "Sniper"]
var weapon_angles = [0, 120, 240]
var selected_weapon = ""

signal weapon_selected(weapon_name)

@onready var wheel = $Wheel
@onready var spawner = $"../../Spawner"


func start_spin():
	print("spinning")
	is_spinning = true
	var random_angle = randf_range(0, 360)
	var full_spins = 360 * 5
	var target_rotation = wheel.rotation + deg_to_rad(full_spins + random_angle)
	var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(wheel, "rotation", target_rotation, spin_duration)
	await tween.finished
	is_spinning = false
	get_result()
	
func get_result():
	var angle = fmod(rad_to_deg(wheel.rotation), 360)
	if angle < 0:
		angle += 360
	for i in range(weapon_angles.size()):
		var start = weapon_angles[i]
		var end = start + 120
		if angle >= start and angle < end:
			selected_weapon = weapons[i]
	emit_signal("weapon_selected", selected_weapon)
	visible = false
	get_tree().paused = false
	spawner.can_spawn = true
	get_node("../../Felix2D").set_weapon(selected_weapon)
