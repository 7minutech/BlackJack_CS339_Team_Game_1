extends Node
var rerolls = 3
var current_scene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reroll():
	var deck = current_scene.get_node("Dealer/Deck")
	var player = current_scene.get_node("Player")
	var dealer = current_scene.get_node("Dealer")
	var hud = current_scene.get_node("HUD")
	print("rerolling")
	print(deck.draw_pile.size())
	var discarded_card = player.hand.pop_back()
	deck.discard_pile.append(discarded_card)
	deck.removeOneFromPlayer(discarded_card)
	hud.find_child("Hands").reduceCards(1,0)
	player.has_bust()
	player.hit(dealer.deal_card())
	current_scene.check_aces()
	current_scene.calculate_total_value()
	current_scene.display_hands()
	var player_hand = player.hand_str()
	var hand_value = player.total_card_value
	player.has_bust()
	var truth: bool = player.bust
	pass # Replace with function body.
