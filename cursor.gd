extends Sprite2D

var cursor_sprite = preload("res://art/cursor.png")
var invalid_cursor_sprite = preload("res://art/invalid_cursor.png")

func set_invalid():
	set_texture(invalid_cursor_sprite)
	
func set_valid():
	set_texture(cursor_sprite)
