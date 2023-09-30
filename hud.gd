extends CanvasLayer

signal start_play

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartPlay/StartTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_start_play()

func update_start_play():
	if $StartPlay/StartTimer.time_left < 1: 
		$StartPlay/StartLabel.text = "Go !"
	else:
		$StartPlay/StartLabel.text = str(int($StartPlay/StartTimer.time_left))


func _on_start_timer_timeout():
	$StartPlay/StartLabel.hide()
	start_play.emit()
