extends Node2D
var player_hand_value 
var dealer_hand_value 
var hud 
var scene_root 
var result
var finished 
var player_hits = 0
const UP = 1
const RIGHT = 2
const DOWN = 3
const LEFT = 4
const MIMIC = 1
const THIEF = 2
const MUTE = 3
var chip_pile = 3
var up_disabled = false
var right_disabled = false
var down_disabled = false
var left_disabled = false
var mimic = false 
var thief = false 
var mute = false
signal hit_pressed_main
signal stand_pressed_main
signal round_over_main
signal down_pressed_main
signal up_pressed_main
signal left_pressed_main
signal right_pressed_main
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AbilityObserver.load_abilities()
	$HUD/BossName.text = "Final Boss"
	SignalBus.hit_pressed.connect(_on_hit_pressed_main)
	SignalBus.stand_pressed.connect(_on_stand_pressed_main)
	SignalBus.down_pressed.connect(_on_down_pressed_main)
	SignalBus.up_pressed.connect(_on_up_pressed_main)
	SignalBus.left_pressed.connect(_on_left_pressed_main)
	SignalBus.right_pressed.connect(_on_right_pressed_main)
	$Dealer/Deck.create_deck()
	$Dealer/Deck.shuffle()
	give_ability("Reroll")
	play_round()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


		
func play_round():
	choose_boss_ability()
	player_hits = 0
	if mute and not $Player.can_stun():
		mute_random_ability()
	await get_tree().create_timer(0.5).timeout
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
	var draw_pile = $Dealer.deal_cards()
	$Dealer.hand.append(draw_pile.pop_front())
	$Player.hand.append(draw_pile.pop_front())
	$Dealer.hand.append(draw_pile.pop_front())
	$Player.hand.append(draw_pile.pop_front())
	$Dealer.hide_face_down()

	
func clear_hand():
	$Dealer.clear_hand()
	$Player.clear_hand()

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
	$Dealer.clear_hand()
	$Player.clear_hand()

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
	player_hits += 1
	$Player.hit($Dealer.deal_card())
	if mimic and not $Player.can_stun():
		$Dealer.hit()
	if dealer_can_steal and thief and not $Player.can_stun():
		evalute_cards()
		display_hands()
		await get_tree().create_timer(0.5).timeout
		steal_card()
	evalute_cards()
	display_hands()
	$Player.has_bust()
	$Dealer.has_bust()
	if $Dealer.bust:
		$Dealer.show_face_down()
		await get_tree().create_timer(1.5).timeout
		round_over_main.emit()
	pass # Replace with function body.

func _on_stand_pressed_main() -> void:
	$Player.stand()
	disable_stand()
	$Dealer.show_face_down()
	if not mimic:
		$Dealer.deal_themself()
	display_hands()
	await get_tree().create_timer(1.5).timeout
	calculate_total_value()
	display_hands()

	round_over_main.emit()
	pass # Replace with function body.

func _on_down_pressed_main(name: String) -> void:
	if name == "Reroll" and $Player.can_reroll() and not down_disabled:
		reroll()
func _on_up_pressed_main(name: String) -> void:
	if name == "Reroll" and $Player.can_reroll() and not up_disabled:
		reroll()
	pass
func _on_left_pressed_main(name: String) -> void:
	if name == "Reroll" and $Player.can_reroll() and not left_disabled:
		reroll()
	pass
func _on_right_pressed_main(name: String) -> void:
	if name == "Reroll" and $Player.can_reroll() and not right_disabled:
		reroll()
	pass

	

func game_over():
	if $Player.has_won():
		switch_to_second_boss()
	if $Dealer.has_won():
		restart()

func _on_round_over_main() -> void:
	$Player.stun_timer += 1
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
	$Player.hit($Dealer.deal_card())
	check_aces()
	calculate_total_value()
	display_hands()
	pass # Replace with function body.

func give_ability(ability_key: String):
	var ability_scene = $AbilityManager.a_dict[ability_key]
	if not $Player.abilities.has(ability_scene):
		$Player.addAbility(ability_scene)
		print("Active:\n " + str($HUD.activesList))
		print("Passive:\n" + str($HUD.passivesList))

func evalute_cards():
	check_aces()
	calculate_total_value()

func dealer_can_steal():
	return player_hits == 1

func steal_card():
	var highest_value = -1
	var highest_value_index 
	for i in range($Player.hand.size()):
		if ($Player.hand[i]).value > highest_value:
			highest_value = $Player.hand[i].value
			highest_value_index = i
	var removed_card = $Player.hand.pop_at(highest_value_index)
	$Dealer/Deck.discard_pile.append(removed_card)
	print("Stealing" + str(removed_card))

func mute_random_ability():
	reset_disabled_abilities()
	var rnum = randi_range(1,4) 
	print(rnum)
	match rnum:
		UP:
			up_disabled = true
		DOWN:
			down_disabled = true
		RIGHT:
			right_disabled = true
		LEFT:
			left_disabled = true

func reset_disabled_abilities():
	up_disabled = false
	right_disabled = false
	down_disabled = false 
	left_disabled = false

func choose_boss_ability():
	reset_boss_ability()
	var rnum = randi_range(1,3) 
	match rnum:
		MIMIC:
			print("mimic")
			mimic = true
		THIEF:
			print("thief")
			thief = true
		MUTE:
			print("mute")
			mute = true

func reset_boss_ability():
	mimic = false
	thief = false 
	mute = false

func switch_to_second_boss():
	SceneSwitcher.switch_scene("res://Scenes/End_Game.tscn")
 
func restart():
	SceneSwitcher.switch_scene("res://Scenes/main.tscn")
	
func disable_stand():
	$HUD/StandButton.disabled = true
	await get_tree().create_timer(2).timeout
	$HUD/StandButton.disabled = false
