class_name BaseIcon extends Icon

var ship_mini_icon_scene: PackedScene = preload("res://global/icons/ship_mini_icon.tscn")

var previous_construction_status: Construction.Status
var base: Base:
	set(value):
		base = value
		$VBoxContainer/Label.text = base.name
		position = base.location
	
func _process(delta):
	super._process(delta)

	for mini_icon in $VBoxContainer/MiniIcons.get_children():
		mini_icon.queue_free()

	if base:
		show_texture()
		for ship in base.get_ships():
			if ship.hangared:
				var ship_mini_icon = ship_mini_icon_scene.instantiate()
				$VBoxContainer/MiniIcons.add_child(ship_mini_icon)
				break

func show_texture():
	if not previous_construction_status or base.construction_status != previous_construction_status:
		if base.construction_status == Construction.Status.IN_PROGRESS:
			$VBoxContainer/TextureRect.visible = false
			$VBoxContainer/ConstructionTextureRect.visible = true
			$VBoxContainer/TextureRect/Area2D/CollisionShape2D.disabled = true
			$AnimationPlayer.play("base_icon", -1, 2.0)
		elif base.construction_status == Construction.Status.DONE:
			$VBoxContainer/TextureRect.visible = true
			$VBoxContainer/ConstructionTextureRect.visible = false
			$VBoxContainer/TextureRect/Area2D/CollisionShape2D.disabled = false
		$VBoxContainer.set_anchors_and_offsets_preset(Control.PRESET_CENTER, Control.PRESET_MODE_MINSIZE, false)
	previous_construction_status = base.construction_status

func _get_texture_rect() -> TextureRect:
	if base.construction_status == Construction.Status.IN_PROGRESS:
		return $VBoxContainer/ConstructionTextureRect
	return $VBoxContainer/TextureRect

