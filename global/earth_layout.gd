extends Node2D

var base_icon_scene: PackedScene = preload("res://global/icons/base_icon.tscn")

var mouse_sens= 500.0
var is_creating_new_base: bool = false
var mouse_pos
var last_mouse_pos
var valid_base_location: bool = false

signal base_creation_over()

func _ready():
	$NewBaseDialog.close()
	mouse_pos = to_local(get_global_mouse_position())
	$Cursor.visible = false
	
	for base in Saver.data.bases:
		add_base(base)
	
	if $Area2D.overlaps_area($Cursor/Area2D):
		$Cursor.set_valid()
		valid_base_location = true
	else:
		$Cursor.set_invalid()
		valid_base_location = false
	
	

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position
		
	if self.is_active():
		if event.is_action_pressed("validate") and valid_base_location:
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

func _on_new_base_dialog_confirmed(base_name):
	var base: BaseData = BaseData.new()
	base.name = base_name
	base.location = Vector2(to_local(last_mouse_pos))
	Saver.data.bases.append(base)
	Saver.save_data()
		
	dialog_closed()
	creating_new_base_over()
	
	add_base(base)

func add_base(base: BaseData):
	var base_icon = base_icon_scene.instantiate()
	base_icon.set_base(base)
	add_child(base_icon)

func _on_area_2d_mouse_entered():
	$Cursor.set_valid()
	valid_base_location = true


func _on_area_2d_mouse_exited():
	$Cursor.set_invalid()
	valid_base_location = false
