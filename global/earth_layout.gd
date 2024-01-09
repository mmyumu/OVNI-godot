extends Node2D

var base_icon_scene: PackedScene = preload("res://global/icons/base_icon.tscn")
var attack_icon_scene: PackedScene = preload("res://global/icons/attack_icon.tscn")
var ship_icon_scene: PackedScene = preload("res://global/icons/ship_icon.tscn")
var attack_info_panel_scene: PackedScene = preload("res://global/panels/attack_info_panel.tscn")
var base_info_panel_scene: PackedScene = preload("res://global/panels/base_info_panel.tscn")

var mouse_sens= 500.0
var is_creating_new_base: bool = false
var mouse_pos
var last_mouse_pos
var valid_base_location: bool = false
var highlighted_base: Base
var highlighted_attack: Attack

var base_icons: Array[BaseIcon] = []
var attack_icons: Array[AttackIcon] = []
var attack_info_panel: AttackInfoPanel
var base_info_panel: BaseInfoPanel


signal base_creation_over()
signal attack_spawned(attack: Attack)

func _init():
	for base in Saver.data.get_bases():
		add_base(base)
		
		for ship in base.get_ships():
			add_ship(ship)

func _ready():
	MastermindIntel.attack_spawned.connect(_on_attack_spawned)
	
	$NewBaseDialog.close()
	mouse_pos = to_local(get_global_mouse_position())
	$Cursor.visible = false

	for attack in Saver.data.mastermind.get_attacks_ongoing():
		add_attack(attack)
	
	if $Area2D.overlaps_area($Cursor/Area2D):
		$Cursor.set_valid()
		valid_base_location = true
	else:
		$Cursor.set_invalid()
		valid_base_location = false
	
	$Area2D/CollisionShape2D.get_shape().size.x = Saver.data.earth.width
	$Area2D/CollisionShape2D.get_shape().size.y = Saver.data.earth.height
	
	$MothershipIcon.play()

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
			get_viewport().set_input_as_handled()

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
		
	$MothershipIcon.position = Saver.data.mastermind.location

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
	var base: Base = Base.new()
	base.name = base_name
	base.location = Vector2(to_local(last_mouse_pos))
	
	Headquarters.start_base_construction(base)

	dialog_closed()
	creating_new_base_over()
	
	add_base(base)

func add_base(base: Base):
	var base_icon = base_icon_scene.instantiate()
	base_icon.name = "%s_%s" % [base_icon.name, base.name]
	base_icon.set_base(base)
	base_icons.append(base_icon)
	add_child(base_icon)
	
	if highlighted_base and highlighted_base.name == base.name:
		base_icon.highlighted = true
	else:
		base_icon.highlighted = false

func highlight_base(base: Base):
	highlighted_base = base
	for base_icon in base_icons:
		if base_icon.base.name == base.name:
			base_icon.highlighted = true
		else:
			base_icon.highlighted = false

func unhighlight_base():
	for base_icon in base_icons:
		base_icon.highlighted = false

func _on_area_2d_mouse_entered():
	$Cursor.set_valid()
	valid_base_location = true

func _on_area_2d_mouse_exited():
	$Cursor.set_invalid()
	valid_base_location = false

func _on_attack_spawned(attack: Attack):
	add_attack(attack)
	attack_spawned.emit(attack)

func add_attack(attack: Attack):
	var attack_icon = attack_icon_scene.instantiate()
	attack_icon.name = "%s_%s" % [attack_icon.name, attack.name]
	attack_icon.set_attack(attack)
	attack_icons.append(attack_icon)
	add_child(attack_icon)
		
	if highlighted_attack and highlighted_attack.name == attack.name:
		attack_icon.highlighted = true
	else:
		attack_icon.highlighted = false

func highlight_attack(attack: Attack):
	highlighted_attack = attack
	for attack_icon in attack_icons:
		if attack_icon.attack.name == attack.name:
			attack_icon.highlighted = true
		else:
			attack_icon.highlighted = false

func unhighlight_attack():
	for attack_icon in attack_icons:
		attack_icon.highlighted = false

func add_ship(ship: Ship):
	var ship_icon = ship_icon_scene.instantiate()
	ship_icon.name = "%s_%s_%s" % [ship_icon.name, ship.base.name, ship.name]
	ship_icon.set_ship(ship)
	add_child(ship_icon)

func show_attack_info(ship: Ship, attack: Attack):
	attack_info_panel = attack_info_panel_scene.instantiate()
	attack_info_panel.set_data(attack, ship)
	attack_info_panel.position.x = attack.location.x + 25
	attack_info_panel.position.y = attack.location.y - 30
	add_child(attack_info_panel)

func hide_attack_info(ship: Ship, attack: Attack):
	if attack_info_panel:
		attack_info_panel.queue_free()

func show_base_info(base: Base):
	base_info_panel = base_info_panel_scene.instantiate()
	base_info_panel.set_data(base)
	add_child(base_info_panel)

func hide_base_info(base: Base):
	if base_info_panel:
		base_info_panel.queue_free()
