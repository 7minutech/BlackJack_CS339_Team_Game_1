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
func _process(delta: float) -> void:
	pass

# Function to clear both hands
func reset() -> void:
	playerCards = 0
	dealerCards = 0
	for node in $PlayerArea.get_children():
		node.queue_free()
	for node in $DealerArea.get_children():
		node.queue_free()
	
# Function to order cards when they are added to the player's and Dealer's hands
func addCardToPlayerHand(newCard: Node2D) -> void:
	playerCards += 1
	newCard.apply_scale(Vector2(CARD_SCALAR,CARD_SCALAR))
	if playerCards == 1:
		newCard.position = Vector2(ROWS_INIT_X, PLAYER_ROW_ONE_Y)
	elif playerCards <= 8:
		var newX: int = ROWS_INIT_X + (NEW_CARD_OFFSET * (playerCards - 1))
		newCard.position = Vector2(newX, PLAYER_ROW_ONE_Y)
	elif playerCards == 9:
		newCard.position = Vector2(ROWS_INIT_X, PLAYER_ROW_TWO_Y)
	elif playerCards <= 16:
		var newX: int = ROWS_INIT_X + (NEW_CARD_OFFSET * (playerCards - 1))
		newCard.position = Vector2(newX, PLAYER_ROW_TWO_Y)
	else:
		print("Out of bounds error! Too many cards in player Hand!")
	$PlayerArea.add_child(newCard)
	
func addCardToDealerHand(newCard: Node2D) -> void:
	newCard.apply_scale(Vector2(CARD_SCALAR,CARD_SCALAR))
	dealerCards += 1
	if dealerCards == 1:
		newCard.position = Vector2(ROWS_INIT_X, DEALER_ROW_ONE_Y)
	elif dealerCards <= 9:
		var newX: int = ROWS_INIT_X + (NEW_CARD_OFFSET * (dealerCards - 1))
		newCard.position = Vector2(newX, DEALER_ROW_ONE_Y)
	elif dealerCards == 10:
		newCard.position = Vector2(ROWS_INIT_X, DEALER_ROW_TWO_Y)
	elif dealerCards <= 18:
		var newX: int = ROWS_INIT_X + (NEW_CARD_OFFSET * (dealerCards - 1))
		newCard.position = Vector2(newX, DEALER_ROW_TWO_Y)
	else:
		print("Out of bounds error! Too many cards in dealer Hand!")
	$DealerArea.add_child(newCard)
