extends Node
var rerolls = 3
var current_scene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#Joker,"Get a card that would make your hand value equal 21",5,p
func joker():
	current_scene.joker_cd = current_scene.turns
	var player = current_scene.get_node("Player")
	var dealer = current_scene.get_node("Dealer")
	var hand = current_scene.get_node("HUD/Hands")
	player.value_ace()
	if player.total_card_value < 21:
		var diff = 21 - player.total_card_value
		var needed_card = dealer.get_card_that_sums_to(diff)
		player.hit(needed_card)
		hand.addCardToPlayerHand(needed_card)
		print("Joker Ability: Player's hand adjusted to 21")
func can_use_joker():
	var player = current_scene.get_node("Player")
	var joker_cd = current_scene.joker_cd
	var ability_manager = current_scene.get_node("AbilityManager")
	var cd = ability_manager.a_dict["Joker"].cooldown
	if player.has_ability("Joker") and (current_scene.turns - joker_cd >= cd 
	or joker_cd == 0):
		return true
	return false

func can_use_peeping_tom():
	current_scene.peeping_tom_cd = current_scene.turns
	var player = current_scene.get_node("Player")
	var peeping_tom_cd = current_scene.peeping_tom_cd
	var ability_manager = current_scene.get_node("AbilityManager")
	var cd = ability_manager.a_dict["Peeping Tom"].cooldown
	if player.has_ability("Peeping Tom") and (current_scene.turns - peeping_tom_cd >= cd 
	or peeping_tom_cd == 0):
		return true
	return false

func peeping_tom_ability():
	var dealer = current_scene.get_node("Dealer")
	#show dealer face-down card
	var dealers_face_down = dealer.hand[0]
	dealers_face_down.face_down = false
	dealers_face_down.flipCard()
	print("Peeping Tom Ability: Player can see the dealer face-down card.")
	
#Time Rewind,"Undo your last hit if it would have made 
#you bust and the dealer would have won the game",0,p

func can_use_rewind():
	var player = current_scene.get_node("Player")
	var dealer = current_scene.get_node("Dealer")	
	var rewind_cd = current_scene.rewind_cd
	var ability_manager = current_scene.get_node("AbilityManager")
	var cd = ability_manager.a_dict["Time Rewind"].cooldown
	if dealer.chips < 2:
		return false
	if player.has_ability("Time Rewind") and (current_scene.turns - rewind_cd >= cd 
	or rewind_cd == 0):
		return true
	return false
func rewind_time_ability():
	current_scene.rewind_cd = current_scene.turns
	var player = current_scene.get_node("Player")
	var dealer = current_scene.get_node("Dealer")	
	current_scene.check_aces()
	current_scene.calculate_total_value()
	#check if the last card bust
	player.has_bust()
	if player.bust:
		await get_tree().create_timer(0.5).timeout
		var bust_card = player.hand.pop_back()
		var deck = current_scene.get_node("Dealer/Deck")
		deck.removeOneFromPlayer(bust_card)
		current_scene.check_aces()
		current_scene.calculate_total_value()
		current_scene.display_hands()
		print("rewind")
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

func gambler():
	var deck = current_scene.get_node("Dealer/Deck")
	var player = current_scene.get_node("Player")
	var dealer = current_scene.get_node("Dealer")
	var hud = current_scene.get_node("HUD")
	var loweset_value = 100
	var lowest_index
	var hand = current_scene.get_node("HUD/Hands")
	for i in range(player.hand.size()):
		if loweset_value > player.hand[i].value:
			loweset_value = player.hand[i].value
			lowest_index = i
	var player_lowest_card = player.hand.pop_at(lowest_index)
	var dealers_face_down = dealer.hand.pop_at(0)
	dealers_face_down.face_down = false
	dealers_face_down.flipCard()
	deck.removeOneFromPlayer(player_lowest_card)
	deck.removeOneFromDealer(dealers_face_down)
	hand.addCardToPlayerHand(dealers_face_down)
	hand.addCardToDealerHand(player_lowest_card)
	player.hand.append(dealers_face_down)
	dealer.hand.append(player_lowest_card)
	current_scene.check_aces()
	current_scene.calculate_total_value()
	current_scene.display_hands()
