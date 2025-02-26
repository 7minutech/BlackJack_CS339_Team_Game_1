extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Deck.create_deck()
	$Deck.shuffle()
	var drawn_card = $Deck.cards.pop_front()
	print(drawn_card)
	
	# Code for testing abilities and file management
	print()
	$AbilityManager.createSelection()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
