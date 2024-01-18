extends Node2D

var base_icon_scene: PackedScene = preload("res://global/icons/base_icon.tscn")
var attack_icon_scene: PackedScene = preload("res://global/icons/attack_icon.tscn")
var ship_icon_scene: PackedScene = preload("res://global/icons/ship_icon.tscn")
var earth_marker_icon_scene: PackedScene = preload("res://global/icons/earth_marker_icon.tscn")
var attack_info_panel_scene: PackedScene = preload("res://global/panels/attack_global_info_panel.tscn")
var base_info_panel_scene: PackedScene = preload("res://global/panels/base_global_info_panel.tscn")

var highlighted_base: Base
var highlighted_attack: Attack

var base_icons: Array[BaseIcon] = []
var attack_icons: Array[AttackIcon] = []
var attack_info_panel: AttackGlobalInfoPanel
var base_info_panel: BaseGlobalInfoPanel


signal base_creation_over()
signal goto_selection_over()
signal attack_spawned(attack: Attack)

func _init():
	for base in Saver.data.get_bases():
		add_base(base)
		
		for ship in base.get_ships():
			add_ship(ship)

	build_earth_markers()

func _ready():
	MastermindIntel.attack_spawned.connect(_on_attack_spawned)
	Ships.ship_new_destination.connect(_on_ship_new_destination)
	
	$NewBaseDialog.close()
	$NewBaseCursor.visible = false
	$GoToCursor.visible = false

	for attack in Saver.data.mastermind.get_attacks_ongoing():
		add_attack(attack)
	
	if $Area2D.overlaps_area($NewBaseCursor/Area2D):
		$NewBaseCursor.set_valid()
	else:
		$NewBaseCursor.set_invalid()

	if $Area2D.overlaps_area($GoToCursor/Area2D):
		$GoToCursor.set_valid()
	else:
		$GoToCursor.set_invalid()
	
	$Area2D/CollisionShape2D.get_shape().size.x = Saver.data.earth.width
	$Area2D/CollisionShape2D.get_shape().size.y = Saver.data.earth.height
	
	$MothershipIcon.play()

func _physics_process(delta):
	$MothershipIcon.position = Saver.data.mastermind.location

func build_earth_markers():
	for ship in Saver.data.get_ships():
		add_earth_marker(ship)

func update_earth_markers():
	for earth_marker_icon in find_children("*", "EarthMarkerIcon", false, false):
		earth_marker_icon.update_icon()

func set_creating_new_base():
	$NewBaseCursor.activate()

func creating_new_base_over():
	$NewBaseCursor.deactivate()
	base_creation_over.emit()

func set_selecting_goto(ship: Ship):
	$GoToCursor.ship = ship
	$GoToCursor.activate()

func selecting_goto_over():
	$GoToCursor.deactivate()
	goto_selection_over.emit()

func dialog_closed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	get_tree().paused = false

func _on_new_base_dialog_canceled():
	dialog_closed()

func _on_new_base_dialog_confirmed(base_name):
	var base: Base = Base.new()
	base.name = base_name
	base.location = Vector2(to_local($NewBaseCursor.last_mouse_pos))
	
	var result = Headquarters.start_base_construction(base)

	dialog_closed()
	creating_new_base_over()
	
	if result:	
		add_base(base)

func add_base(base: Base):
	var base_icon = base_icon_scene.instantiate()
	base_icon.name = "%s_%s" % [base_icon.name, base.name]
	base_icon.base = base
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
	$NewBaseCursor.set_valid()
	$GoToCursor.set_valid()

func _on_area_2d_mouse_exited():
	$NewBaseCursor.set_invalid()
	$GoToCursor.set_invalid()

func _on_attack_spawned(attack: Attack):
	add_attack(attack)

func add_attack(attack: Attack):
	var attack_icon = attack_icon_scene.instantiate()
	attack_icon.name = "%s_%s" % [attack_icon.name, attack.name]
	attack_icon.attack = attack
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

func add_earth_marker(ship: Ship):
	var earth_marker_icon = earth_marker_icon_scene.instantiate()
	earth_marker_icon.name = "%s_%s_%s" % [earth_marker_icon.name, ship.base.name, ship.name]
	earth_marker_icon.ship = ship
	add_child(earth_marker_icon)

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

func _on_new_base_cursor_canceled():
	creating_new_base_over()

func _on_new_base_cursor_validated():
	$NewBaseDialog.open()

func _on_go_to_cursor_validated():
	var hovered = false
	for node in find_children("*", "Icon", false, false):
		if node.hovered:
			hovered = true
			if node is AttackIcon:
				Ships.move_to($GoToCursor.ship, node.attack)
			elif node is BaseIcon:
				Ships.move_to($GoToCursor.ship, node.base)
			return
	
	if not hovered:
		var earth_marker = EarthMarker.new(Vector2(to_local($GoToCursor.last_mouse_pos)))
		Ships.move_to($GoToCursor.ship, earth_marker)

	selecting_goto_over()

func _on_go_to_cursor_canceled():
	selecting_goto_over()

func _on_ship_new_destination(ship: Ship):
	update_earth_markers()
