extends Node2D
var player_hand_value 
var dealer_hand_value 
var hud 
var scene_root 
var result
var finished 
var chip_pile = 3
var switching = false
var round_timer
signal hit_pressed_main
signal stand_pressed_main
signal round_over_main
signal down_pressed_main
signal up_pressed_main
signal left_pressed_main
signal right_pressed_main
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/BossName.text = "Tutorial Boss"
	SignalBus.hit_pressed.connect(_on_hit_pressed_main)
	SignalBus.stand_pressed.connect(_on_stand_pressed_main)
	SignalBus.down_pressed.connect(_on_down_pressed_main)
	SignalBus.up_pressed.connect(_on_up_pressed_main)
	SignalBus.left_pressed.connect(_on_left_pressed_main)
	SignalBus.right_pressed.connect(_on_right_pressed_main)
	$Dealer/Deck.create_deck()
	$Dealer/Deck.shuffle()
	$AbilityManager.createSelection()
	give_ability("Reroll")
	#print($Player.abiliites)
	round_timer = get_tree().create_timer(0.5)
	play_round()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
# Function to handle input events
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()

		
func play_round():
	round_timer = get_tree().create_timer(0.5)
	await round_timer.timeout
	$Dealer/Deck.check_reshuffle()
	reset_players()
	add_discard_pile()
	clear_hands()
	deal_cards()
	check_aces()
	calculate_total_value()
	display_hands()
	display_chips()
	#print("before")
	await round_over_main
	#print("after")
	if player_has_won():
		player_win()
	elif dealer_has_won():
		dealer_win()
	else:
		tie()
	game_over()
	play_round()
	
	 

func wait_for_player():
	await round_over_main
	
	
func player_hit():
	$Player.hit($Dealer.deal_card())

func player_split():
	$Player.split()

func all_stand():
	player_hand_value = $Player.stand()
	dealer_hand_value = $Dealer.stand()

func deal_cards():
	var draw_pile: Array[Node2D] = $Dealer.deal_cards()
	for i in range(4):
		var drawn: Node2D = draw_pile.pop_front()
		if (i % 2) == 1:
			$Dealer.hand.append(drawn)
			$HUD/Hands.addCardToDealerHand(drawn)
		if (i % 2) == 0:
			$Player.hand.append(drawn)
			$HUD/Hands.addCardToPlayerHand(drawn)
	$Dealer.hide_face_down()

func determine_winner():
	pass
	
func player_has_won():
	var diff = $Player.total_card_value - $Dealer.total_card_value
	$Dealer.has_bust()
	if $Dealer.bust:
		return true
	if not $Player.bust and diff > 0:
		return true
	return false

func dealer_has_won():
	var diff = $Dealer.total_card_value - $Player.total_card_value
	if $Player.bust:
		return true
	if not $Dealer.bust and diff > 0:
		return true
	return false
func player_win():
	$HUD/RoundMessage.text = "You win!"
	$Player.win_chip()
	if chip_pile <= 0:
		$Dealer.lose_chip()
	else:
		chip_pile -= 1
func dealer_win():
	$HUD/RoundMessage.text = "You lose!"
	$Dealer.win_chip()
	if chip_pile <= 0:
		$Player.lose_chip()
	else:
		chip_pile -= 1

func tie():
	$HUD/RoundMessage.text = "You tie!"
	pass

func round_over():
	if $Player.is_standing() or $Player.has_bust():
		return true 
	return false

func clear_hands():
	$Dealer/Deck.clearTable($Player.hand, $Dealer.hand)
	$Dealer.clear_hand()
	$Player.clear_hand()
	$HUD/Hands.reset()

func add_discard_pile():
	for card in $Dealer.hand:
		$Dealer/Deck.discard_pile.append(card)
	for card in $Player.hand:
		$Dealer/Deck.discard_pile.append(card)

func display_hands():
	$HUD/PlayerHand.text = "Player " + $Player.hand_str()
	$HUD/DealerHand.text = "Dealer " + $Dealer.hand_str()
 
func display_chips():
	$HUD/PlayerChip.text = str($Player.chips)
	$HUD/DealerChip.text = str($Dealer.chips)

func calculate_total_value():
	$Player.sum_card_value()
	$Dealer.sum_card_value()



func _on_hit_pressed_main() -> void:
	var newCard: Node2D = $Dealer.deal_card()
	$Player.hit(newCard)
	check_aces()
	calculate_total_value()
	display_hands()
	$Player.has_bust()
	pass # Replace with function body.

func _on_stand_pressed_main() -> void:
	$Player.stand()
	disable_stand()
	$Dealer.show_face_down()
	$Dealer.deal_themself()
	display_hands()
	await get_tree().create_timer(1.5).timeout
	calculate_total_value()
	display_hands()
	round_over_main.emit()
	pass # Replace with function body.

func _on_down_pressed_main(a_name: String) -> void:
	if a_name == "Reroll" and $Player.has_ability(a_name):
		reroll()
func _on_up_pressed_main(a_name: String) -> void:
	pass
func _on_left_pressed_main(a_name: String) -> void:
	pass
func _on_right_pressed_main(a_name: String) -> void:
	pass

	

func game_over():
	if $Player.has_won():
		switch_to_first_boss()
	if $Dealer.has_won():
		restart()

func _on_round_over_main() -> void:
	pass # Replace with function body.

func reset_players():
	$Player.round_reset()
	$Dealer.round_reset()

func check_aces():
	$Player.value_ace()
	$Dealer.value_ace()

func reroll():
	print("rerolling")
	var discarded_card = $Player.hand.pop_back()
	$Dealer/Deck.discard_pile.append(discarded_card)
	$Dealer/Deck.removeOneFromPlayer(discarded_card)
	$Player.has_bust()
	$Player.hit($Dealer.deal_card())
	check_aces()
	calculate_total_value()
	display_hands()
	var player_hand = $Player.hand_str()
	var hand_value = $Player.total_card_value
	$Player.has_bust()
	var truth: bool = $Player.bust
	pass # Replace with function body.

# Function to add an ability to the player's abilities list
func give_ability(ability_key: String):
	var ability_scene = $AbilityManager.a_dict[ability_key]
	if not $Player.abilities.has(ability_scene):
		$Player.addAbility(ability_scene)
		print("Active: ")
		for a in $HUD.activesList:
			print(a)
		print("Passive: ")
		for a in $HUD.passivesList:
			print(a)

func switch_to_first_boss():
	SceneSwitcher.switch_scene("res://Scenes/main.tscn")

func restart():
	SceneSwitcher.switch_scene("res://Scenes/main.tscn")
	
func disable_stand():
	$HUD/StandButton.disabled = true
	await get_tree().create_timer(2).timeout
	$HUD/StandButton.disabled = false

	
	
