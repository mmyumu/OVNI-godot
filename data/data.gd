class_name Data extends Resource


@export var datetime: DatetimeData = DatetimeData.new()
@export var bases: Array[BaseData]
@export var mastermind: MasterMindData = MasterMindData.new()
@export var earth: EarthData = EarthData.new()


func get_data_name():
	if len(bases) > 0:
		return bases[0].name
	else:
		return "New game"
