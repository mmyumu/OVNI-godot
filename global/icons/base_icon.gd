@tool
class_name BaseIcon extends Node2D

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

var base: BaseData

var highlighted: bool:
	set(value):
		highlighted = value
		queue_redraw()
		blink()

var tween: Tween

func set_base(base_to_set: BaseData):
	base = base_to_set
	$Label.text = base.name
	position = base.location

func _draw():
	if highlighted:
		var width = $Sprite2D.texture.get_width()
		var height = $Sprite2D.texture.get_height()
		var sprite_position = $Sprite2D.position

		var top_left = Vector2(sprite_position.x - width/2 - padding, sprite_position.y - height/2 - padding)
		var top_right = Vector2(sprite_position.x + width/2 + padding, sprite_position.y - height/2 - padding)
		var bottom_left = Vector2(sprite_position.x - width/2 - padding, sprite_position.y + height/2 + padding)
		var bottom_right = Vector2(sprite_position.x + width/2 + padding, sprite_position.y + height/2 + padding)

		draw_line(top_left, top_right, color, thickness)
		draw_line(top_right, bottom_right, color, thickness)
		draw_line(bottom_right, bottom_left, color, thickness)
		draw_line(bottom_left, top_left, color, thickness)

		$Label.set("theme_override_colors/font_color", color)
	else:
		$Label.set("theme_override_colors/font_color", Color.WHITE)

func blink():
	if highlighted:
		tween = create_tween()
		
		tween.tween_property($Label, "theme_override_colors/font_color", Color.WHITE, 0.5)
		tween.chain().tween_property($Label, "theme_override_colors/font_color", color, 0.5)
		tween.set_loops()
	else:
		if tween:
			tween.stop()
