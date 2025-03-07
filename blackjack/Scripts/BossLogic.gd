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
var tutorial_boss = false
var final_boss = false
var mimic_boss = false
var thief_boss = false
var mute_boss = false
var round_timer
var ability_selected
var ability_1 = 0
var ability_2 = 0
var ability_3 = 0
var ability_4 = 0
var turns = 0
signal hit_pressed_main
signal stand_pressed_main
signal round_over_main
signal down_pressed_main
signal up_pressed_main
signal left_pressed_main
signal right_pressed_main
signal option_pressed_main
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	determin_boss()
	
	AbilityLogic.current_scene = self
	AbilityObserver.main = self
	if tutorial_boss:
		AbilityObserver.save_abilities()
	AbilityObserver.load_abilities()
	$HUD/BossName.text =  name + " Boss"
	SignalBus.hit_pressed.connect(_on_hit_pressed_main)
	SignalBus.stand_pressed.connect(_on_stand_pressed_main)
	SignalBus.down_pressed.connect(_on_down_pressed_main)
	SignalBus.up_pressed.connect(_on_up_pressed_main)
	SignalBus.left_pressed.connect(_on_left_pressed_main)
	SignalBus.right_pressed.connect(_on_right_pressed_main)
	SignalBus.option_pressed.connect(_on_option_pressed_main)
	$Dealer/Deck.create_big_deck()
	$Dealer/Deck.shuffle()
	$AbilityManager.createSelection()
	if tutorial_boss or mute_boss:
		give_ability("Reroll")
	round_timer = get_tree().create_timer(0.5)
	disable_stand(1)
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
	turns += 1
	if final_boss:
		choose_boss_ability()
	player_hits = 0
	if (mute or mute_boss) and not $Player.can_stun():
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
	$Player.has_bust()
	if $Dealer.bust and not $Player.bust:
		return true
	if not $Player.bust and diff > 0:
		return true
	return false

func dealer_has_won():
	var diff = $Dealer.total_card_value - $Player.total_card_value
	$Dealer.has_bust()
	$Player.has_bust()
	if $Player.bust and not $Dealer.bust:
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
	player_hits += 1
	var newCard: Node2D = $Dealer.deal_card()
	$Player.hit(newCard)
	check_aces()
	calculate_total_value()
	if (mimic or mimic_boss) and not $Player.can_stun():
		var newCard2: Node2D = $Dealer.deal_card()
		$Dealer.hit()
	if dealer_can_steal() and (thief or thief_boss) and not $Player.can_stun():
		evalute_cards()
		display_hands()
		await get_tree().create_timer(0.5).timeout
		steal_card()
	evalute_cards()
	display_hands()
	$Player.has_bust()
	pass # Replace with function body.

func _on_stand_pressed_main() -> void:
	$Player.stand()
	disable_stand(2)
	$Dealer.show_face_down()
	if not mimic:
		$Dealer.deal_themself()
	display_hands()
	await get_tree().create_timer(1.5).timeout
	calculate_total_value()
	display_hands()
	round_over_main.emit()
	pass # Replace with function body.

func _on_down_pressed_main(a_name: String) -> void:
	checkAbility(a_name)
func _on_up_pressed_main(a_name: String) -> void:
	checkAbility(a_name)
func _on_left_pressed_main(a_name: String) -> void:
	checkAbility(a_name)
func _on_right_pressed_main(a_name: String) -> void:
	checkAbility(a_name)

func checkAbility(a_name: String) -> void:
	var cd = $AbilityManager.a_dict[a_name].cooldown
	match a_name:
		"Reroll":
			if $Player.has_ability(a_name) and (turns - ability_1 >= cd or ability_1 == 0):
				AbilityLogic.reroll()
				ability_1 = turns
		"Gambler":
			if $Player.has_ability(a_name) and (turns - ability_2>= cd or ability_2== 0):
				AbilityLogic.gambler()
				ability_2 = turns
		_:
			print("Invalid name supplied to main.gd checkAbility() method")

func game_over():
	if $Player.has_won():
		switch_to_next_boss()
	if $Dealer.has_won():
		restart()

func _on_round_over_main() -> void:
	$Player.stun_timer += 1
	play_round()
	pass # Replace with function body.

func reset_players():
	$Player.round_reset()
	$Dealer.round_reset()

func check_aces():
	$Player.value_ace()
	$Dealer.value_ace()


# Function to add an ability to the player's abilities list
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
	$Dealer/Deck.removeOneFromPlayer(removed_card)
	$Dealer/Deck.discard_pile.append(removed_card)
	print("Stealing" + str(removed_card))

func mute_random_ability():
	reset_disabled_abilities()
	var numActive = $HUD.activesList.size()
	var rnum = randi_range(1, numActive)
	match rnum:
		0:
			$HUD/Button_Down.disabled = true
		1:
			$HUD/Button_Right.disabled = true 
		2:
			$HUD/Button_Left.disabled = true
		3:
			$HUD/Button_Up.disabled = true 



func reset_disabled_abilities():
	var numActive = $HUD.activesList.size()

	for i:int in range(numActive):
		match i:
			0:
				$HUD/Button_Down.disabled = false
			1:
				$HUD/Button_Right.disabled = false 
			2:
				$HUD/Button_Left.disabled = false
			3:
				$HUD/Button_Up.disabled = false 

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

func switch_to_next_boss():
	if tutorial_boss:
		SceneSwitcher.switch_scene("res://Scenes/First_Boss_Fight.tscn", true)
	elif mimic_boss:
		SceneSwitcher.switch_scene("res://Scenes/Second_Boss_Fight.tscn", true)
	elif thief_boss:
		SceneSwitcher.switch_scene("res://Scenes/Third_Boss_Fight.tscn", true)
	elif mute_boss:
		SceneSwitcher.switch_scene("res://Scenes/Final_Boss_Fight.tscn", true)
	elif final_boss:
		SceneSwitcher.switch_scene("res://Scenes/End_Game.tscn", true)
		

func determin_boss():
	if self.name == "Tutorial":
		tutorial_boss = true
	elif self.name == "FirstBoss":
		mimic_boss = true
	elif self.name == "SecondBoss":
		thief_boss = true
	elif self.name == "ThirdBoss":
		mute_boss = true
	elif self.name == "FinalBoss":
		final_boss = true

func restart():
	get_tree().quit()
	
func disable_stand(duration):
	$HUD/StandButton.disabled = true
	await get_tree().create_timer(duration).timeout
	$HUD/StandButton.disabled = false

func _on_option_pressed_main() -> void:
	ability_selected = true
	$AbilityManager/Selection.hideOptions()
