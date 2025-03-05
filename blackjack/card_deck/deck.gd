extends Node2D

const card_scene = preload("res://card_deck/card.tscn")
const DECK_POSITION: Vector2 = Vector2(-1000, -1000)
var draw_pile: Array[Node2D] = []
var discard_pile: Array[Node2D] = []
var royalty = ["jack", "queen", "king", "ace"]
var numbers = [2, 3, 4, 5, 6, 7, 8, 9, 10]
var suits = ["club", "heart", "spade", "diamond"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func shuffle():
	draw_pile.shuffle()
	randomize()

func reshuffle():
	draw_pile += discard_pile
	shuffle()

func check_reshuffle():
	if draw_pile.size() < 10:
		reshuffle()


func create_deck():
	for suit in suits:
		for j in range(13):
			var rank
			var value

			if j < 9:
				value = numbers[j]  # Numbers 2-10
				rank = "number" # Assing rank to number draw_pile
			elif j == 12:
				value = 11  # Face draw_pile are worth 10
				rank = royalty[j - 9]  # Assign face card rank (jack, queen, king, ace)
			else:
				value = 10  # Face draw_pile are worth 10
				rank = royalty[j - 9]  # Assign face card rank (jack, queen, king, ace)

			var card: Node2D = card_scene.instantiate()
			card.create_card(value, rank, suit)
			card.position = DECK_POSITION
			self.add_child(card)
			draw_pile.append(card)

func display_total_cards():
	print(draw_pile.size())

func draw_card() -> Node2D:
	var drawn_card = draw_pile.pop_front()
	return drawn_card	

# Function to clear the cards from the table
func clearTable(p_hand: Array[Node2D], d_hand: Array[Node2D]) -> void:
	for card in p_hand:
		card.position = DECK_POSITION
	for card in d_hand:
		card.position = DECK_POSITION

# Functions to clear one card from the dealer or player area
func removeOneFromPlayer(card: Node2D) -> void:
	card.position = DECK_POSITION
	get_parent().get_parent().find_child("HUD").find_child("Hands").reduceCards(1,0)
func removeOneFromDealer(card: Node2D) -> void:
	card.position = DECK_POSITION
	get_parent().get_parent().find_child("HUD").find_child("Hands").reduceCards(0,1)
	
