class_name MoneyManager extends Node

func spend(amount: int):
	Saver.data.money -= amount

func earn(amount: int):
	Saver.data.money += amount
