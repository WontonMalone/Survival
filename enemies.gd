extends Area2D

@export var speed = 50
@export var hp = 10
var stopped = false

func _process(delta):
	if not stopped:
		position.x -= speed * delta
	
func take_damage(amount):
	hp -= amount
	if hp <=0:
		queue_free()

func _ready():
	print("enemy spawned at: ", global_position)
