extends Node
var rerolls = 3
var current_scene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func joker_ability():
	var player = current_scene.get_node("Player")
	var dealer = current_scene.get_node("Dealer")
	if player.total_card_value < 21:
		var diff = 21 - player.total_card_value
		var needed_card = dealer.get_card_that_sums_to(diff)
		player.hit(needed_card)
		print("Joker Ability: Player's hand adjusted to 21")
		

func peeping_tom_ability():
	var dealer = current_scene.get_node("Dealer")
	var hud = current_scene.get_node("HUD")
	#show dealer face-down card
	hud.show_dealers_face_down_card(dealer.face_down_card)
	print("Peeping Tom Ability: Player can see the dealer face-down card.")
	

func rewind_time_ability():
	var player = current_scene.get_node("Player")
	var dealer = current_scene.get_node("Dealer")
	var hud = current_scene.get_node("HUD")
	
	#check if the last card bust
	if player.total_card_value > 21:
		var last_card = player.hand.pop_back()
		dealer.add_card_to_deck(last_card)
		hud.update_hand_display(player.hand)
		current_scene.calculate_total_value()
		current_scene.display_hands()
		print("Rewind Time Ability: Last card undone to prevent bust.")

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
