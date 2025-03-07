extends Node

var deck = []  # Holds the shuffled deck
var hand = []  # Holds dealer's cards
var hidden_card = null  # The face-down card
func generate_shuffled_deck():
	var suits = ["hearts", "diamonds", "clubs", "spades"]
	var values = [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]
	var new_deck = []

	for suit in suits:
		for value in values:
			new_deck.append({"suit": suit, "value": value})

	new_deck.shuffle()
	return new_deck


func _ready():
	shuffle_deck()

func shuffle_deck():
	deck = generate_shuffled_deck()

func deal_card(to_hand):
	if deck.size() > 0:
		var card = deck.pop_front()
		to_hand.append(card)
		return card
	return null

func initial_deal(player_hand):
	hand.append(deal_card(player_hand))  # Player first card
	hidden_card = deal_card(hand)  # Dealer face-down card
	hand.append(deal_card(player_hand))  # Player second card
	hand.append(deal_card(hand))  # Dealer face-up card

func reveal_hidden_card():
	hand.append(hidden_card)
	hidden_card = null

func play_turn():
	reveal_hidden_card()
	while get_hand_value() < 17:
		deal_card(hand)

func get_hand_value():
	var total = 0
	var ace_count = 0
	for card in hand:
		total += card.get_value()
		if card.is_ace():
			ace_count += 1
	while total > 21 and ace_count > 0:
		total -= 10
		ace_count -= 1
	return total
