extends Node

func spend(amount: int) -> bool:
	if Saver.data.money >= amount:
		Saver.data.money -= amount
		return true
	return false

func earn(amount: int):
	Saver.data.money += amount
