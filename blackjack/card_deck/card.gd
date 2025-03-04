extends Node2D
class_name  Card
var face_down = false
@export var value: int 
@export var rank: String
@export var suit: String
@export var royalty = ["jack", "queen", "king", "ace"]
@onready var animated_sprite_2d: AnimatedSprite2D = $card_sprite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
func create_card(v, r, s):
	self.rank = r 
	self.value = v
	self.suit = s
	if self.value == 11:
		$card_sprite.animation = self.suit +"s_a"
	elif self.rank == "number":
		$card_sprite.animation = self.suit +"s_" + str(self.value)
	else:
		$card_sprite.animation = self.suit +"s_" + self.rank[0]
	'''This is where code will go to change the boss symbols on the card
	match bossName:
		mimic:
			$card_sprite/boss_symbol.animation = mimic
			$card_sprite/boss_symbol.animation = mimic
		
		... Continue like the above with other boss names
		
		_: #This line means default case
			$card_sprite/boss_symbol.animation = tutorial
			$card_sprite/boss_symbol2.animation = tutorial
			
	'''

func _to_string() -> String:
	if rank in royalty:
		return "[Rank=%s, Suit=%s]" % [rank, suit]
	else:
		return "[Value=%d, Suit=%s]" % [value, suit]

func display_card():
	print("rank: " + rank + " value: " +str(value) + " suit: " + suit)
