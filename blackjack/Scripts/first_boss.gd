extends Node2D
var player_hand_value 
var dealer_hand_value 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Mimic/Deck.create_deck()
	$Mimic/Deck.shuffle()
	play_round()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func play_game():
	while not ($Player.has_lost() or $Mimic.has_lost()):
		play_round()
		
func play_round():
	add_discard_pile()
	clear_hands()
	deal_cards()
	if round_over():
		if player_has_won():
			player_win()
		elif dealer_has_won():
			dealer_win()
		else:
			tie()
		
	
	
func player_hit():
	$Player.hit($Mimic.deal_card())

func player_split():
	$Player.split()

func player_stand():
	player_hand_value = $Player.stand()
	dealer_hand_value = $Mimic.stand()

func deal_cards():
	var draw_pile = $Mimic.deal_cards()
	$Mimic.hand.append(draw_pile.pop_front())
	$Player.hand.append(draw_pile.pop_front())
	$Mimic.hand.append(draw_pile.pop_front())
	$Player.hand.append(draw_pile.pop_front())
	
func clear_hands():
	$Mimic.clear_hand()
	$Player.clear_hand()

func determine_winner():
	pass
	
func player_has_won():
	var diff = player_hand_value - dealer_hand_value
	if not $Player.bust and diff > 0:
		return true
	return false

func dealer_has_won():
	var diff = player_hand_value - dealer_hand_value
	if not $Mimic.bust and diff > 0:
		return true
	return false
func player_win():
	$Player.gain_chip()
	$Dealer.lose_chip()
func dealer_win():
	$Player.loss_chip()
	$Dealer.win_chip()

func tie():
	pass

func round_over():
	if $Player.is_standing() or $Player.has_bust():
		return true 
	return false

func add_discard_pile():
	for card in $Mimic.hand:
		$Mimic/Deck.discard_pile.append(card)
	for card in $Player.hand:
		$Mimic/Deck.discard_pile.append(card)
	
