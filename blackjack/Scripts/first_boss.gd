extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_round():
	clear_hands()
	deal_cards()
	
	
	

func deal_cards():
	var draw_pile = $Mimic.deal_cards()
	$Mimic.hand.append(draw_pile.pop_front())
	$Player.hand.append(draw_pile.pop_front())
	$Mimic.hand.append(draw_pile.pop_front())
	$Player.hand.append(draw_pile.pop_front())
	
func clear_hands():
	$Mimic.clear_hand()
	$Player.clear_hand()
	
