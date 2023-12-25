class_name Data extends Resource


@export var datetime: DatetimeData = DatetimeData.new()
@export var bases: Dictionary = {}
@export var mastermind: MasterMindData = MasterMindData.new()
@export var earth: EarthData = EarthData.new()


func get_data_name():
	if len(bases) > 0:
		return bases[bases.keys()[0]].name
	else:
		return "New game"

func add_base(base: BaseData):
	bases[base.id] = base
