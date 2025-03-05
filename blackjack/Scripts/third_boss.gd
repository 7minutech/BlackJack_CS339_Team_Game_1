extends Node2D
var player_hand_value 
var dealer_hand_value 
var hud 
var scene_root 
var result
var finished
var mute = false 
var chip_pile = 3
const UP = 1
const RIGHT = 2
const DOWN = 3
const LEFT = 4
var up_disabled = false
var right_disabled = false
var down_disabled = false
var left_disabled = false

signal hit_pressed_main
signal stand_pressed_main
signal round_over_main
signal down_pressed_main
signal up_pressed_main
signal left_pressed_main
signal right_pressed_main
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/BossName.text = "Mute Boss"
	SignalBus.hit_pressed.connect(_on_hit_pressed_main)
	SignalBus.stand_pressed.connect(_on_stand_pressed_main)
	SignalBus.down_pressed.connect(_on_down_pressed_main)
	SignalBus.up_pressed.connect(_on_up_pressed_main)
	SignalBus.left_pressed.connect(_on_left_pressed_main)
	SignalBus.right_pressed.connect(_on_right_pressed_main)
	$Dealer/Deck.create_deck()
	$Dealer/Deck.shuffle()
	$AbilityManager.tesstSelection()
	give_ability("Reroll")
	#print($Player.abiliites)
	$HUD.addAbilities()
	play_round()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


		
func play_round():
	if not $Player.can_stun():
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
	$Player.hit($Dealer.deal_card())
	check_aces()
	calculate_total_value()
	display_hands()
	$Player.has_bust()
	pass # Replace with function body.

func _on_stand_pressed_main() -> void:
	disable_stand()
	$Player.stand()
	$Dealer.show_face_down()
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
	$Player.has_bust()
	pass # Replace with function body.

func give_ability(ability_key: String):
	var ability_scene = $AbilityManager.a_list[ability_key]
	$Player.addAbility(ability_scene)

func mute_random_ability():
	reset_disabled_abilities()
	var rnum = randi_range(1,4) 
	print(rnum)
	match rnum:
		UP:
			up_disabled = true
			print(up_disabled)
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
			
func switch_to_second_boss():
	SceneSwitcher.switch_scene("res://Scenes/Final_Boss_Fight.tscn")

func restart():
	SceneSwitcher.switch_scene("res://Scenes/main.tscn")
	
func disable_stand():
	$HUD/StandButton.disabled = true
	await get_tree().create_timer(2).timeout
	$HUD/StandButton.disabled = false
