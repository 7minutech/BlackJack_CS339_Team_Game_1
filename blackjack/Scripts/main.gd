extends Node2D
var player_hand_value 
var dealer_hand_value 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Dealer/Deck.create_deck()
	$Dealer/Deck.shuffle()
	play_round()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func play_game():
	while not ($Player.has_lost() or $Dealer.has_lost()):
		play_round()
		
func play_round():
	add_discard_pile()
	clear_hands()
	deal_cards()
	$Player.show_hand()
	$Dealer.show_hand()
	if round_over():
		if player_has_won():
			player_win()
		elif dealer_has_won():
			dealer_win()
		else:
			tie()
		
	
	
func player_hit():
	$Player.hit($Dealer.deal_card())

func player_split():
	$Player.split()

func player_stand():
	player_hand_value = $Player.stand()
	dealer_hand_value = $Dealer.stand()

func deal_cards():
	var draw_pile = $Dealer.deal_cards()
	$Dealer.hand.append(draw_pile.pop_front())
	$Player.hand.append(draw_pile.pop_front())
	$Dealer.hand.append(draw_pile.pop_front())
	$Player.hand.append(draw_pile.pop_front())
	
func clear_hand():
	$Dealer.clear_hand()
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
	if not $Dealer.bust and diff > 0:
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

func clear_hands():
	$Dealer.clear_hand()
	$Player.clear_hand()

func add_discard_pile():
	for card in $Dealer.hand:
		$Dealer/Deck.discard_pile.append(card)
	for card in $Player.hand:
		$Dealer/Deck.discard_pile.append(card)
	
