extends Node

var hand = []
var chips = 3
var total_card_value 
var selected_cards = []
var bust = false

# Called Swhen the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sum_card_value()
	pass
	
func deal_card():
	return $Deck.draw_card()
func deal_cards():
	var drawn_cards = []
	for i in range(4):
		drawn_cards.append($Deck.draw_card)	
	return drawn_cards

func lose_chip():
	chips -= 1;

func clear_hand():
	hand = []
	
func hit(card):
	hand.append(card)
	
func clear_selected_cards():
	selected_cards = []
	
func has_bust():
	if total_card_value > 21:
		bust = true
	
func can_split_cards(card1,card2):
	if card1.value == card1.value && card1.rank == card2.rank && selected_cards.length == 2:
		return true
	return false
	
func sum_card_value():
	total_card_value = 0
	for card in hand:
		total_card_value += card.value

func stand():
	total_card_value
	
func has_lost():
	if chips <= 0:
		return true
	return false
	
func reset():
	clear_hand()
	bust = false
	chips = 3
	total_card_value = 0
	
