extends Control

@onready var gold_label = $"../GoldLabel"
@onready var upgrade_result_label = $PanelGO/UpgradeResultLabel


func _ready():
	update_gold_display()

func update_gold_display():
	gold_label.text = "Gold: " + str(GameData.gold)


func _on_hp_upgrade_pressed():
	if GameData.gold >= 10:
		GameData.gold -= 10
		GameData.hp_upgrade += 1
		upgrade_result_label.text = "HP increased by 5!"
		update_gold_display()
	else:
		upgrade_result_label.text = "Not enough gold!"

func _on_damage_upgrade_pressed():
	if GameData.gold >= 10:
		GameData.gold -=10
		var roll = randi() % 3
		if roll == 0:
			GameData.damage_upgrade += 1
			upgrade_result_label.text = "Damage Upgraded!"
		elif roll == 1:
			GameData.fire_rate_upgrade += 1
			upgrade_result_label.text = "Fire Rate Upgraded!"
		else:
			GameData.ammo_upgrade += 1
			upgrade_result_label.text = "Ammo Upgraded!"
		update_gold_display()
	else:
		upgrade_result_label.text = "Not Enough Gold!"

func _on_enemy_weakness_upgrade_pressed():
	if GameData.gold >= 10:
		GameData.gold -= 10
		var roll = randi() % 2
		if roll == 0:
			GameData.enemy_speed_upgrade += 1
			upgrade_result_label.text = "Enemies are slower!"
		else:
			GameData.enemy_hp_upgrade += 1
			upgrade_result_label.text = "Enemies are weaker!"
		update_gold_display()
	else:
		upgrade_result_label.text = "Not Enough Gold!"
func _on_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
