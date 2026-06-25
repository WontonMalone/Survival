extends Area2D

var enemies_in_zone = 0

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	enemies_in_zone += 1
	area.stopped = true
	
func _on_area_exited(area):
	enemies_in_zone -= 1
	area.stopped = false

func _process(delta):
	if enemies_in_zone > 0:
		get_parent().take_damage(2 * enemies_in_zone * delta)
