extends Node
var deck_obj
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Deck.create_deck()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("fsd")
	pass
