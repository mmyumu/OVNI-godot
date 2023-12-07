extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	Datetimer.day_changed.connect(_on_day_changed)

func _on_day_changed(date: DatetimeData.Datetime):
	print("Master mind plans attacks")
	var attack_date = DatetimeData.Datetime.new(date.timestamp + rng.randi_range(0, 86400))
	print("Attack planned on %s" % attack_date.get_datetime_str())
