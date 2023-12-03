class_name Data extends Resource


@export var datetime: DatetimeData = DatetimeData.new()
@export var bases: Array[BaseData]


func get_data_name():
	if len(bases) > 0:
		return bases[0].name
	else:
		return "New game"
