extends Node2D

var base_icon_scene: PackedScene = preload("res://global/icons/base_icon.tscn")
var attack_icon_scene: PackedScene = preload("res://global/icons/attack_icon.tscn")
var ship_icon_scene: PackedScene = preload("res://global/icons/ship_icon.tscn")
var event_info_panel_scene: PackedScene = preload("res://global/event_info_panel.tscn")

var mouse_sens= 500.0
var is_creating_new_base: bool = false
var mouse_pos
var last_mouse_pos
var valid_base_location: bool = false
var highlighted_base: BaseData
var highlighted_attack: AttackData

var base_icons: Array[BaseIcon] = []
var attack_icons: Array[AttackIcon] = []
var event_info_panel: EventInfoPanel


signal base_creation_over()
signal attack_spawned(attack: AttackData)

func _init():
	for base in Saver.data.get_bases():
		add_base(base)
		
		for ship in base.get_ships():
			add_ship(ship)

func _ready():
	MasterMind.attack_spawned.connect(_on_attack_spawned)
	
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
	var ship: ShipData = ShipData.new()
	Saver.data.add_ship(ship)
	ship.name = "Raptor"
	ship.hangared = true
	
	var base: BaseData = BaseData.new()
	base.name = base_name
	base.location = Vector2(to_local(last_mouse_pos))
	base.add_ship(ship)
	
	ship.base = base
	ship.location = base.location
	
	Saver.data.add_base(base)
	Saver.save_data()
		
	dialog_closed()
	creating_new_base_over()
	
	add_base(base)
	add_ship(ship)

func add_base(base: BaseData):
	var base_icon = base_icon_scene.instantiate()
	base_icon.name = "%s_%s" % [base_icon.name, base.name]
	base_icon.set_base(base)
	base_icons.append(base_icon)
	add_child(base_icon)
	
	if highlighted_base and highlighted_base.name == base.name:
		base_icon.highlighted = true
	else:
		base_icon.highlighted = false

func highlight_base(base: BaseData):
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

func _on_attack_spawned(attack: AttackData):
	add_attack(attack)
	attack_spawned.emit(attack)

func add_attack(attack: AttackData):
	var attack_icon = attack_icon_scene.instantiate()
	attack_icon.name = "%s_%s" % [attack_icon.name, attack.name]
	attack_icon.set_attack(attack)
	attack_icons.append(attack_icon)
	add_child(attack_icon)
		
	if highlighted_attack and highlighted_attack.name == attack.name:
		attack_icon.highlighted = true
	else:
		attack_icon.highlighted = false

func highlight_attack(attack: AttackData):
	highlighted_attack = attack
	for attack_icon in attack_icons:
		if attack_icon.attack.name == attack.name:
			attack_icon.highlighted = true
		else:
			attack_icon.highlighted = false

func unhighlight_attack():
	for attack_icon in attack_icons:
		attack_icon.highlighted = false

func add_ship(ship: ShipData):
	var ship_icon = ship_icon_scene.instantiate()
	ship_icon.name = "%s_%s_%s" % [ship_icon.name, ship.base.name, ship.name]
	ship_icon.set_ship(ship)
	add_child(ship_icon)

func show_event_info(ship: ShipData, attack: AttackData):
	event_info_panel = event_info_panel_scene.instantiate()
	event_info_panel.set_data(ship, attack)
	event_info_panel.position.x = attack.location.x + 25
	event_info_panel.position.y = attack.location.y - 30
	add_child(event_info_panel)

func hide_event_info(ship: ShipData, attack: AttackData):
	if event_info_panel:
		event_info_panel.queue_free()
