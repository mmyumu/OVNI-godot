extends Node2D

func _process(delta):
	$GridContainer/MoneyValue.text = "%s $" % Saver.data.money
