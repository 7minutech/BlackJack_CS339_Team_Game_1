extends Node

var cards = []
var abiliites = []
var chips = 3
var total_card_value 
var selected_cards = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func clear_cards():
	cards = []

func clear_selected_cards():
	selected_cards = []
	
func has_bust():
	if total_card_value > 21:
		return true
	return false
	
func can_split_cards(card1,card2):
	if card1.value == card1.value && card1.rank == card2.rank && selected_cards.length == 2:
		return true
	return false
	
func sum_card_value():
	total_card_value = 0
	for card in cards:
		total_card_value += card.value
	
func player_lost():
	if chips <= 0:
		return true
	return false
