extends Node2D

var mouse_sens= 500.0
var is_creating_new_base: bool = false
var mouse_pos
var last_mouse_pos

signal base_creation_over()

func _ready():
	$NewBaseDialog.close()
	mouse_pos = to_local(get_global_mouse_position())

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position
	if self.is_active():
		if event.is_action_pressed("validate"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			last_mouse_pos = get_global_mouse_position()
			$NewBaseDialog.open()
		elif event.is_action_pressed("cancel"):
			creating_new_base_over()

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
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	$Cursor.visible = true
	is_creating_new_base = true

func creating_new_base_over():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Cursor.visible = false
	is_creating_new_base = false
	base_creation_over.emit()

func dialog_closed():
	Input.warp_mouse(last_mouse_pos)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	get_tree().paused = false

func _on_new_base_dialog_canceled():
	dialog_closed()
	print("canceled")

func _on_new_base_dialog_confirmed():
	dialog_closed()
	creating_new_base_over()
	print("confirmed")
