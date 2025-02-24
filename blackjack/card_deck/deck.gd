extends Node2D

var card_scene = preload("res://card_deck/card.tscn")
var cards = []
var royalty = ["jack", "queen", "king", "ace"]
var numbers = [2, 3, 4, 5, 6, 7, 8, 9, 10]
var suits = ["club", "heart", "spade", "diamond"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func shuffle():
	randomize()
	cards.shuffle()

func create_deck():
	for suit in suits:
		for j in range(13):
			var rank
			var value

			if j < 9:
				value = numbers[j]  # Numbers 2-10
				rank = "number" # Assing rank to number cards
			else:
				value = 10  # Face cards are worth 10
				rank = royalty[j - 9]  # Assign face card rank (jack, queen, king, ace)

			var card = card_scene.instantiate()
			card.create_card(value, rank, suit)
			add_child(card)
			cards.append(card)
			print(card)
