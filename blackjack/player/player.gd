extends Node

var hand = []
var hand_2 = []
var abiliites = []
var chips = 3
var total_card_value 
var selected_cards = []
var bust = false
var standing = false
var is_split = false
# Called Swhen the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sum_card_value()
	pass
	
func lose_chip():
	chips -= 1;

func clear_hand():
	hand = []
	
func hit(card):
	if not bust: 
		hand.append(card)
	
func clear_selected_cards():
	selected_cards = []
	
func has_bust():
	if total_card_value > 21:
		bust = true

func is_standing():
	if standing:
		return true
	return false
	
func split(card_1,card_2):
	if can_split_cards(card_1, card_2):
		var index = hand.find(card_2)
		hand_2.append(hand.pop_at(index))	
		is_split = true
	return
func can_split_cards(card_1,card_2):
	if card_1.value == card_2.value && card_1.rank == card_2.rank && selected_cards.length == 2:
		return true
	return false
	
func sum_card_value():
	total_card_value = 0
	for card in hand:
		total_card_value += card.value

func stand():
	standing = true
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
	is_split = false
	standing = false
	
