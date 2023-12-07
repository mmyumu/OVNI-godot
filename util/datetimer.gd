extends Node

@export var time_factor = 1.0
#var previous_date: DatetimeData.Datetime

signal day_changed(date: DatetimeData.Datetime)

func _ready():
	set_physics_process_internal(true)

func _physics_process(delta):
	var dates = Saver.data.datetime.spent(delta * time_factor)
	var previous_date: DatetimeData.Datetime = dates[0]
	var new_date: DatetimeData.Datetime = dates[1]
	if new_date.changed_day(previous_date):
		print("previous_date=%s, new_date=%s"% [previous_date.get_datetime_str(), new_date.get_datetime_str()])
		day_changed.emit(new_date)
#	previous_date = new_date
