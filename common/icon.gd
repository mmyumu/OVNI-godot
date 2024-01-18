class_name Icon extends Node2D

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

var highlighted: bool:
	set(value):
		highlighted = value
		queue_redraw()
		blink()

var hovered: bool = false:
	set(value):
		hovered = value
		queue_redraw()

var tween: Tween
var frame_number: int = 0



#func _ready():
	##build_collision_shape()
	#print("rect=%s" % _get_texture_rect().get_rect())
	#
#
#func build_collision_shape():
	#var shape = RectangleShape2D.new()
	#var rect = _get_texture_rect().get_rect()
	#shape.size.x = _get_texture_rect().get_rect().size.x
	#shape.size.y = _get_texture_rect().get_rect().size.y
	#
	#$Area2D/CollisionShape2D.set_shape(shape)
	#$Area2D/CollisionShape2D.position.x = _get_texture_rect().get_rect().position.x
	#$Area2D/CollisionShape2D.position.y = _get_texture_rect().get_rect().position.y


func _process(delta):
	# Redraw on second frame since some info can miss on first frame (such as Sprite position)
	if frame_number == 0:
		frame_number = 1
	elif frame_number == 1:
		queue_redraw()
		frame_number = 2

func _draw():
	if highlighted:
		draw_highlight(color)
	elif hovered:
		draw_highlight(Color.DARK_SLATE_GRAY)
	else:
		$VBoxContainer/Label.set("theme_override_colors/font_color", Color.WHITE)
	$VBoxContainer.set_anchors_and_offsets_preset(Control.PRESET_CENTER, Control.PRESET_MODE_MINSIZE, false)

func draw_highlight(_color: Color):
	var texture_rect = _get_texture_rect()
		
	if texture_rect:
		var width = texture_rect.texture.get_width()
		var height = texture_rect.texture.get_height()
		var sprite_position = $VBoxContainer.position + texture_rect.position
		
		var top_left = Vector2(sprite_position.x - padding, sprite_position.y - padding)
		var top_right = Vector2(sprite_position.x + width + padding, sprite_position.y - padding)
		var bottom_left = Vector2(sprite_position.x - padding, sprite_position.y + height + padding)
		var bottom_right = Vector2(sprite_position.x + width + padding, sprite_position.y + height + padding)

		draw_line(top_left, top_right, _color, thickness)
		draw_line(top_right, bottom_right, _color, thickness)
		draw_line(bottom_right, bottom_left, _color, thickness)
		draw_line(bottom_left, top_left, _color, thickness)

		$VBoxContainer/Label.set("theme_override_colors/font_color", color)

func _get_texture_rect() -> TextureRect:
	return $VBoxContainer/TextureRect

func blink():
	if highlighted:
		tween = create_tween()
		
		tween.tween_property($VBoxContainer/Label, "theme_override_colors/font_color", Color.WHITE, 0.5)
		tween.chain().tween_property($VBoxContainer/Label, "theme_override_colors/font_color", color, 0.5)
		tween.set_loops()
	else:
		if tween:
			tween.stop()

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group('cursor'):
		hovered = true

func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group('cursor'):
		hovered = false
