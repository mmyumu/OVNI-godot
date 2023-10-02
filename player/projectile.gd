extends Area2D

@export var speed: int = 800
var velocity: Vector2 = Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
#	print("x, y= ", position.x, ",", position.y)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
