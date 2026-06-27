extends CanvasLayer

@onready var crosshair = $crosshair2d


var pistol_tex = preload("res://Assets/Desert Shooter Pack/PNG/Crosshair/Pistol.png")
var smg_tex = preload("res://Assets/Desert Shooter Pack/PNG/Crosshair/SMG.png")
var sniper_tex = preload("res://Assets/Desert Shooter Pack/PNG/Crosshair/Sniper.png")

func _ready():
	hide_crosshair()

func _process(_delta):
	crosshair.global_position = get_viewport().get_mouse_position()

func set_crosshair(weapon_name: String):
	match weapon_name:
		"Pistol": crosshair.texture = pistol_tex
		"SMG": crosshair.texture = smg_tex
		"Sniper": crosshair.texture = sniper_tex

func show_crosshair():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	visible = true

func hide_crosshair():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	visible = false
	
