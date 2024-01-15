extends Node

func can_spend(amount: int) -> bool:
	return Saver.data.money >= amount

func spend(amount: int) -> bool:
	if can_spend(amount):
		Saver.data.money -= amount
		return true
	return false

func earn(amount: int):
	Saver.data.money += amount
