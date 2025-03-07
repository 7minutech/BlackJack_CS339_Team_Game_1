extends Node

var hand: Array[Node2D] = []
var chips: int = 0
var total_card_value: int = 0
var bust: bool = false
var standing: bool = false
var reversed: bool = false


func _ready() -> void:
	reset()

# Deal a single card to the dealer's hand
func deal_card() -> Node2D:
	var card = $Deck.draw_card()
	return card 
func deal_cards() -> Array[Node2D]:
	var drawn_cards: Array[Node2D] = []
	for i in range(4):
		var drawn_card: Node2D = $Deck.draw_card()
		drawn_cards.append(drawn_card)	
	return drawn_cards

func hit():
	var card: Node2D = deal_card()
	hand.append(card)
	get_parent().find_child("HUD").find_child("Hands").addCardToDealerHand(card)

# Sum the values of cards in the dealer's hand
func sum_card_value() -> void:
	total_card_value = 0
	for card in hand:
		total_card_value += card.value

# Dealer stands with the current hand
func stand() -> void:
	if reversed:
		standing = false
		reversed = true
	else:
		standing = true


func has_bust():
	sum_card_value()
	if total_card_value > 21:
		bust = true
	else:
		bust = false

func value_ace():
	for card in hand:
		if card.rank == "ace":
			sum_card_value()
			if total_card_value > 21:
				card.value = 1
	sum_card_value()

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
func has_won() -> bool:
	return chips >= 10

# Reveal the face-down card (for display purposes)
func reveal_face_down_card() -> void:
	# Implement visual reveal logic here if needed
	pass
func clear_hand():
	hand.clear()

func show_hand():
	for card in hand:
		print(card)
		
func hand_str() -> String:
	var card_str = ""
	var known_value = 0
	for card in hand:
		if card.face_down:
			card_str += "[hidden] "
		else:
			card_str += card._to_string()
	for card in hand:
		if not card.face_down:
			known_value += card.value
	card_str += " Value: " + str(known_value)
	return card_str

func round_reset():
	bust = false


func deal_themself():
	sum_card_value()
	while total_card_value < 17:
		await get_tree().create_timer(1.5).timeout
		hit()
		value_ace()
		sum_card_value()
		get_parent().display_hands()
		await get_tree().create_timer(1.5).timeout
	await get_tree().create_timer(1.5).timeout
	has_bust()
	
func hide_face_down():
	hand[0].face_down = true
	hand[0].flipCard()
func show_face_down():
	hand[0].face_down = false  
	hand[0].flipCard()
		
