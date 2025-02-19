extends Node2D
var card_scene = preload("res://card_deck/card.tscn")
var card
var cards = []
var royalty = ["king","queen","jack","ace"]
var numbers = [2,3,4,5,6,7,8,9,10]
var suits = ["club","heart","spade","diamond22"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func shuffle():
	cards.shuffle
	
func create_deck():
	for i in 4:
		var suit = suits[i]
		for j in 13:
			var value
			var rank 
			if j < 8:
				value = numbers[j]	
				rank = "number"
			if j < 13:
				value = 10		
		card = card_scene.instantiate()				
	
	
