extends Node2D

var mouse_sens= 500.0
var is_creating_new_base: bool = false
var mouse_pos

signal base_creation_over()

func _ready():
	mouse_pos = to_local(get_global_mouse_position())
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position
	if self.is_active():
		if event.is_action_pressed("validate"):
			print("validate new base")
			is_creating_new_base = false
			$Cursor.visible = false
			base_creation_over.emit()
		elif event.is_action_pressed("cancel"):
			print("cancel new base")
			is_creating_new_base = false
			$Cursor.visible = false
			base_creation_over.emit()

func _physics_process(delta):
	if self.is_active():
		var direction: Vector2
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

		if abs(direction.x) == 1 and abs(direction.y) == 1:
			direction = direction.normalized()

		var movement = mouse_sens * direction * delta
		if (movement):  
			Input.warp_mouse(mouse_pos + movement)
		mouse_pos = get_global_mouse_position()
		$Cursor.position = to_local(mouse_pos)

func is_active():
	return is_creating_new_base

func set_creating_new_base():
	$Cursor.visible = true
	is_creating_new_base = true
