extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func play_game():
	while not ($Player.has_lost() or $Mimic.has_lost()):
		play_round()
		
func play_round():
	clear_hands()
	deal_cards()
	if round_over():
		determine_winner()
		if player_has_won():
			player_win()
		else:
			dealer_win()
		
	
	
	

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
	return true
	pass
func player_win():
	$Player.gain_chip()
	$Dealer.lose_chip()
func dealer_win():
	$Player.loss_chip()
	$Dealer.win_chip()

func round_over():
	if $Player.is_standing() or $Player.has_bust():
		return true 
	return false
	
