extends Node2D
class_name  Card
@export var value: int 
@export var rank: String
@export var suit: String
@export var royalty = ["jack", "queen", "king", "ace"]
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func create_card(value, rank, suit):
	self.rank = rank 
	self.value = value 
	self.suit = suit

func _to_string() -> String:
	if rank in royalty:
		return "[Rank=%s, Suit=%s]" % [rank, suit]
	else:
		return "[Value=%d, Suit=%s]" % [value, suit]

func display_card():
	print("rank: " + rank + " value: " +str(value) + " suit: " + suit)
