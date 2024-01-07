class_name BaseIcon extends Node2D

var ship_mini_icon_scene: PackedScene = preload("res://global/icons/ship_mini_icon.tscn")

@export var color: Color = Color("bc7235"):
	set(value):
		color = value
		queue_redraw()

@export_range(0, 10, 0.01) var thickness: float = 1.0:
	set(value):
		thickness = value
		queue_redraw()

@export_range(0, 10, 1) var padding: int = 1:
	set(value):
		padding = value
		queue_redraw()

var base: Base
var frame_number: int = 0
var previous_construction_status: Construction.Status

var highlighted: bool:
	set(value):
		highlighted = value
		queue_redraw()
		blink()

var tween: Tween

func set_base(base_to_set: Base):
	base = base_to_set
	$VBoxContainer/Label.text = base.name
	position = base.location


func _process(delta):
	# Redraw on second frame since some info can miss on first frame (such as Sprite position)
	if frame_number == 0:
		frame_number = 1
	elif frame_number == 1:
		queue_redraw()
		frame_number = 2

	for mini_icon in $VBoxContainer/MiniIcons.get_children():
		mini_icon.queue_free()

	if base:
		load_texture()
		for ship in base.get_ships():
			if ship.hangared:
				var ship_mini_icon = ship_mini_icon_scene.instantiate()
				$VBoxContainer/MiniIcons.add_child(ship_mini_icon)
				break

func _draw():
	if highlighted:
		draw_highlight()
	else:
		$VBoxContainer/Label.set("theme_override_colors/font_color", Color.WHITE)

func load_texture():
	if not previous_construction_status or base.construction_status != previous_construction_status:
		if base.construction_status == Construction.Status.IN_PROGRESS:
			$VBoxContainer/BaseTextureRect.visible = false
			$VBoxContainer/ConstructionTextureRect.visible = true
		elif base.construction_status == Construction.Status.DONE:
			$VBoxContainer/BaseTextureRect.visible = true
			$VBoxContainer/ConstructionTextureRect.visible = false
	previous_construction_status = base.construction_status

func draw_highlight():
	var texture_rect
	if base and base.construction_status == Construction.Status.IN_PROGRESS:
		texture_rect = $VBoxContainer/ConstructionTextureRect
	elif base and base.construction_status == Construction.Status.DONE:
		texture_rect = $VBoxContainer/BaseTextureRect
		
	if texture_rect:
		var width = texture_rect.texture.get_width()
		var height = texture_rect.texture.get_height()
		var sprite_position = $VBoxContainer.position + texture_rect.position
		
		var top_left = Vector2(sprite_position.x - padding, sprite_position.y - padding)
		var top_right = Vector2(sprite_position.x + width + padding, sprite_position.y - padding)
		var bottom_left = Vector2(sprite_position.x - padding, sprite_position.y + height + padding)
		var bottom_right = Vector2(sprite_position.x + width + padding, sprite_position.y + height + padding)

		draw_line(top_left, top_right, color, thickness)
		draw_line(top_right, bottom_right, color, thickness)
		draw_line(bottom_right, bottom_left, color, thickness)
		draw_line(bottom_left, top_left, color, thickness)

		$VBoxContainer/Label.set("theme_override_colors/font_color", color)

func blink():
	if highlighted:
		tween = create_tween()
		
		tween.tween_property($VBoxContainer/Label, "theme_override_colors/font_color", Color.WHITE, 0.5)
		tween.chain().tween_property($VBoxContainer/Label, "theme_override_colors/font_color", color, 0.5)
		tween.set_loops()
	else:
		if tween:
			tween.stop()
