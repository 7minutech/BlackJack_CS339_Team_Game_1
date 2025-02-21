extends Node2D
var card_scene = preload("res://card_deck/card.tscn")
var card = card_scene.instantiate()
var cards = []
var royalty = ["king","queen","jack","ace"]
var numbers = [2,3,4,5,6,7,8,9,10]
var suits = ["club","heart","spade","diamond"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_deck()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func shuffle():
	cards.shuffle
	
func create_deck():
	var rank 
	var suit
	var value 
	for i in len(suits):
		suit = suits[i]
		for j in 13:
			if j < 9:
				value = numbers[j]	
				rank = "number"
			if j > 8:
				value = 10		
				rank = royalty[j - 9]
		add_child(card)
		card.create_card(value, rank, suit)	
		cards.append(card)
		card.print_card()
	
	
