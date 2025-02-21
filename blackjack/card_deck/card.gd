extends Node2D
var value
var rank
var suit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func create_card(value, rank, suit):
	rank = rank 
	value = value 
	suit = suit

func print_card():
	print(rank)
	print(value)
	print(suit)
	#print("rank: " + rank + "value: " + value + "suit: " + suit)
