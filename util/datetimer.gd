extends Node

@export var time_factor = 1.0

signal day_changed(date: DatetimeData)

func _ready():
	set_physics_process_internal(true)

func _physics_process(delta):
	var dates = Saver.data.datetime.spent(delta * time_factor)
	var previous_date: DatetimeData = dates[0]
	var new_date: DatetimeData = dates[1]
	if new_date.changed_day(previous_date):
		day_changed.emit(new_date)
