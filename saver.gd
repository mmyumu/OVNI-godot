extends Node


var file_name: String = "user://save_debug.res"

var data: Data

func _init():
	data = Data.new()
	print("init saver")

func set_no_debug():
	file_name = "user://save.res"

func save_data():
	var result = ResourceSaver.save(data, file_name)
	assert(result == OK)

func load_data():
	if ResourceLoader.exists(file_name):
		var loaded_data = ResourceLoader.load(file_name)
		if loaded_data is Data: # Check that the data is valid
			data = loaded_data
