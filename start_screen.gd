extends CanvasLayer

@onready var spawner = $"../../Spawner"

func _ready():
	get_tree().paused = true

func _on_start_button_pressed():
	print("Game Started")
	$ButtonSound.play()
	visible = false
	var weapon_wheel = get_node("../../UI/WeaponWheel")
	weapon_wheel.visible = true
	weapon_wheel.start_spin()
	
	
func _on_options_pressed():
	$ButtonSound.play()
	print("Options")
