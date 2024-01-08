extends Node

@export var time_factor = 1.0

var previous_date: Datetime

signal day_changed(date: Datetime)

func _ready():
	set_physics_process_internal(true)

func _physics_process(delta):
	spend(delta * time_factor)

func spend(time_to_spend: float):
	var new_date = Saver.data.datetime.spend(time_to_spend)
	if new_date.changed_day(previous_date):
		print("Changed day: %s -> %s" % [previous_date.get_datetime_str(), new_date.get_datetime_str()])
		day_changed.emit(new_date)
	previous_date = Datetime.new(new_date.timestamp)
