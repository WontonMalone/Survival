extends Node2D

@onready var game_over_screen = $"../UI/GameOverScreen"


@onready var hp_label = $"../UI/HPLabel"
@onready var gold_label = $"../UI/GoldLabel"
@onready var ammo_label = $"../UI/AmmoLabel"
@onready var gun_sound = $GunSound
@onready var machinegun = $machinegun
@onready var pistol = $pistol
@onready var sniper = $sniper



@export var hp = 10
@export var gold = 0
@export var ammo = 8
@export var max_ammo = 8
@export var damage = 2.0
@export var fire_rate = 1.0
@export var fire_timer = 0.0

var is_holding = false
var is_auto = false
var can_shoot = true
var is_reloading = false
var reload_time = 4.0
var active_sound = null
var pistol_sound = preload("res://Audio/Sound Effects/pistol.ogg")
var machinegun_sound = preload("res://Audio/Sound Effects/machinegun.ogg")
var sniper_sound = preload("res://Audio/Sound Effects/sniper.ogg")

func _ready():
	hp = 10 + (GameData.hp_upgrade * 5)
	update_ui()

func _process(delta):
	fire_timer -= delta
	if is_holding and is_auto and fire_timer <= 0:
		shoot()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_holding = true
				if fire_timer <= 0:
					shoot()
				else:
					is_holding = false

func shoot():
	if is_reloading or ammo <= 0:
		return
	print("active sound: ", active_sound)
	gun_sound.stream = active_sound
	gun_sound.play()
	fire_timer = fire_rate
	ammo -= 1
	update_ui()
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collision_mask = 1
	var results = space_state.intersect_point(query)
	print("results: ", results)
	for result in results:
		if result.collider.is_in_group("enemies"):
			result.collider.take_damage(damage)
	if ammo <= 0:
		reload()

func reload():
	is_reloading = true
	ammo_label.text = "Reloading..."
	await get_tree().create_timer(reload_time).timeout
	ammo = max_ammo
	is_reloading = false
	update_ui()

func take_damage(amount):
	hp -= amount
	update_ui()
	print("Felix hp: ", hp)
	if hp <= 0:
		$LoseAudio.play()
		get_tree().paused = true
		game_over_screen.visible = true
		get_node("../crosshair").hide_crosshair()
		print("Game Over")

	
func update_ui():
	gold_label.text = "Gold: " + str(GameData.gold)
	hp_label.text = "HP: " + str(roundi(hp))
	ammo_label.text = "Ammo: " + str(ammo)

func set_weapon(weapon_name: String):
	print("set_weapon called with: ", weapon_name)
	if weapon_name == "Pistol":
		pistol.visible = true
		machinegun.visible = false
		sniper.visible = false
		active_sound = pistol_sound
		damage = 2.5 + (GameData.damage_upgrade * .25)
		fire_rate = .8 - (GameData.fire_rate_upgrade * 0.1)
		is_auto = false
		ammo = 8 + GameData.ammo_upgrade
		max_ammo = ammo
		reload_time = 1.5 - (GameData.fire_rate_upgrade * 0.2)
	elif weapon_name == "SMG":
		pistol.visible = false
		machinegun.visible = true
		sniper.visible = false
		active_sound = machinegun_sound
		damage = 1.25 + (GameData.damage_upgrade * 0.2)
		is_auto = true
		fire_rate = .2 - (GameData.fire_rate_upgrade * 0.02)
		ammo = 24 + (GameData.ammo_upgrade)
		max_ammo = ammo
		reload_time = 1.88 - (GameData.fire_rate_upgrade * 0.1)
	elif weapon_name == "Sniper":
		pistol.visible = false
		machinegun.visible = false
		sniper.visible = true
		active_sound = sniper_sound
		damage = 5.0 + (GameData.damage_upgrade * 0.5)
		fire_rate = 1.25 - (GameData.fire_rate_upgrade * 0.1)
		is_auto = false
		ammo = 4 + GameData.ammo_upgrade
		max_ammo = ammo
		reload_time = 2.0 - (GameData.fire_rate_upgrade * 0.2)
	fire_rate = max(fire_rate, 0.05)
	reload_time = max(reload_time, 0.5)
	update_ui()
