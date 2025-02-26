extends Node

var hand: Array = []
var chips: int = 3
var total_card_value: int = 0
var bust: bool = false
var standing: bool = false


func _ready() -> void:
	reset()

# Deal a single card to the dealer's hand
func deal_card(card: Node) -> void:
	hand.append(card)
	sum_card_value()
	if total_card_value > 21:
		bust = true


func initial_deal(deck: Node) -> void:
	deal_card(deck.draw_card()) # Face down card
	deal_card(deck.draw_card()) # Face up card

# Dealer hits until reaching at least 17
func hit_until_stand(deck: Node) -> void:
	while total_card_value < 17 and not bust:
		deal_card(deck.draw_card())
		await get_tree().create_timer(0.5).timeout # Small delay for realism
	stand()

# Sum the values of cards in the dealer's hand
func sum_card_value() -> void:
	total_card_value = 0
	for card in hand:
		total_card_value += card.value

# Dealer stands with the current hand
func stand() -> void:
	standing = true


func has_bust() -> bool:
	return bust

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
