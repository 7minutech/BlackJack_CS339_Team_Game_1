extends Node2D

const ROWS_INIT_X: int = 244
const PLAYER_ROW_ONE_Y: int = 411
const PLAYER_ROW_TWO_Y: int = 442
const DEALER_ROW_ONE_Y: int = 95
const DEALER_ROW_TWO_Y: int = 126
const CARD_SCALAR: float = 2.142
const NEW_CARD_OFFSET: int = 90

var playerCards: int = 0
var dealerCards: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerCards = 0
	dealerCards = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Function to clear both hands
func reset() -> void:
	playerCards = 0
	dealerCards = 0

# Function to reduce number of cards in the player and dealer hands
func reduceCards(p_cards: int, d_cards: int) -> void:
	playerCards -= p_cards
	dealerCards -= d_cards

# Function to order cards when they are added to the player's and Dealer's hands
func addCardToPlayerHand(nextCard: Node2D) -> void:
	playerCards += 1
	nextCard.apply_scale(Vector2(CARD_SCALAR,CARD_SCALAR))
	if playerCards == 1:
		nextCard.position = Vector2(ROWS_INIT_X, PLAYER_ROW_ONE_Y)
	elif playerCards <= 8:
		var newX: int = ROWS_INIT_X + (NEW_CARD_OFFSET * (playerCards - 1))
		nextCard.position = Vector2(newX, PLAYER_ROW_ONE_Y)
	elif playerCards == 9:
		nextCard.z_index += 1
		nextCard.position = Vector2(ROWS_INIT_X, PLAYER_ROW_TWO_Y)
	elif playerCards <= 16:
		var newX: int = ROWS_INIT_X + (NEW_CARD_OFFSET * (playerCards - 9))
		nextCard.z_index += 1
		nextCard.position = Vector2(newX, PLAYER_ROW_TWO_Y)
	else:
		print("Out of bounds error! Too many cards in player Hand!")
	
func addCardToDealerHand(nextCard: Node2D) -> void:
	dealerCards += 1
	nextCard.apply_scale(Vector2(CARD_SCALAR,CARD_SCALAR))
	if dealerCards == 1:
		nextCard.position = Vector2(ROWS_INIT_X, DEALER_ROW_ONE_Y)
	elif dealerCards <= 8:
		var newX: int = ROWS_INIT_X + (NEW_CARD_OFFSET * (dealerCards - 1))
		nextCard.position = Vector2(newX, DEALER_ROW_ONE_Y)
	elif dealerCards == 9:
		nextCard.z_index += 1
		nextCard.position = Vector2(ROWS_INIT_X, DEALER_ROW_TWO_Y)
	elif dealerCards <= 16:
		var newX: int = ROWS_INIT_X + (NEW_CARD_OFFSET * (dealerCards - 9))
		nextCard.z_index += 1
		nextCard.position = Vector2(newX, DEALER_ROW_TWO_Y)
	else:
		print("Out of bounds error! Too many cards in dealer Hand!")
