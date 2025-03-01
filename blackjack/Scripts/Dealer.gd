extends Node

var hand: Array = []
var chips: int = 3
var total_card_value: int = 0
var bust: bool = false
var standing: bool = false


func _ready() -> void:
	reset()

# Deal a single card to the dealer's hand
func deal_card():
	var card = $Deck.draw_card()
	return $Deck.draw_card()
func deal_cards():
	var drawn_cards = []
	for i in range(4):
		var drawn_card = $Deck.draw_card()
		drawn_cards.append(drawn_card)	
	return drawn_cards



# Sum the values of cards in the dealer's hand
func sum_card_value() -> void:
	total_card_value = 0
	for card in hand:
		total_card_value += card.value

# Dealer stands with the current hand
func stand() -> void:
	standing = true


func has_bust():
	if total_card_value > 21:
		bust = true

# Reset dealer state for a new round
func reset() -> void:
	hand.clear()
	total_card_value = 0
	bust = false
	standing = false

# Dealer wins a chip
func win_chip() -> void:
	chips += 1

# Dealer loses a chip
func lose_chip() -> void:
	chips -= 1

# Check if dealer has lost (no chips left)
func has_lost() -> bool:
	return chips <= 0

# Reveal the face-down card (for display purposes)
func reveal_face_down_card() -> void:
	# Implement visual reveal logic here if needed
	pass
func clear_hand():
	hand = []

func show_hand():
	for card in hand:
		print(card)
		
func hand_str():
	var str = ""
	for card in hand:
		str += card._to_string()
	str += " Value: " + str(total_card_value)
	return str

func round_reset():
	bust = false


func deal_themself():
	sum_card_value()
	while total_card_value < 17:
		hand.append(deal_card())
		sum_card_value()
		get_parent().display_hands()
		await get_tree().create_timer(1.5).timeout
	has_bust()
	
		
		
