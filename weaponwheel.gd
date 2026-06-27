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
	
	var weapon_index = randi() % weapons.size()
	selected_weapon = weapons[weapon_index]
	
	var segment_center = weapon_angles[weapon_index] + 60.0
	var target_angle = fmod(360.0 - segment_center, 360.0)
	
	var full_spins = 360 * 5
	var target_rotation = deg_to_rad(full_spins + target_angle)
	
	wheel.rotation = 0.0
	var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(wheel, "rotation", target_rotation, spin_duration)
	await tween.finished
	is_spinning = false
	
	emit_signal("weapon_selected", selected_weapon)
	visible = false
	get_tree().paused = false
	spawner.can_spawn = true
	get_node("../../Felix2D").set_weapon(selected_weapon)
	get_node("../../crosshair").set_crosshair(selected_weapon)
	
#func get_result():
	#var angle = fmod(rad_to_deg(wheel.rotation), 360)
	#if angle < 0:
	#	angle += 360
	#for i in range(weapon_angles.size()):
	#	var start = weapon_angles[i]
	#	var end = start + 120
	#	if angle >= start and angle < end:
	#		selected_weapon = weapons[i]
	#emit_signal("weapon_selected", selected_weapon)
	#visible = false
	#get_tree().paused = false
	#spawner.can_spawn = true
	#get_node("../../Felix2D").set_weapon(selected_weapon)
