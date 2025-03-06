extends Node2D
class_name  Card
var face_down = false
const FINAL_BOSS_SPRITES: Array[String] = ["final_mimic","final_mute","final_thief"]
const TUTORIAL_SCALE: Vector2 = Vector2(0.22,0.18)
const MIMIC_SCALE: Vector2 = Vector2(0.154,0.148)
const THIEF_SCALE: Vector2 = Vector2(0.05,0.05)
const FINAL_THIEF_SCALE: Vector2 = Vector2(0.034,0.034)
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

func setSprites() -> void:
	if self.value == 11:
		$card_sprite.animation = self.suit +"s_a"
	elif self.rank == "number":
		$card_sprite.animation = self.suit +"s_" + str(self.value)
	else:
		$card_sprite.animation = self.suit +"s_" + self.rank[0]
	#This is where code will go to change the boss symbols on the card
	var bossName: String = get_parent().get_parent().get_parent().find_child("HUD").find_child("BossName").get_text()
	match bossName:
		"Tutorial Boss":
			$card_sprite/boss_symbol.animation = "tutorial"
			$card_sprite/boss_symbol2.animation = "tutorial"
			$card_sprite/boss_symbol.scale = TUTORIAL_SCALE
			$card_sprite/boss_symbol2.scale = TUTORIAL_SCALE
		"Mimic Boss":
			$card_sprite/boss_symbol.animation = "mimic"
			$card_sprite/boss_symbol2.animation = "mimic"
			$card_sprite/boss_symbol.scale.x = MIMIC_SCALE
			$card_sprite/boss_symbol2.scale = MIMIC_SCALE
		"Mute Boss":
			$card_sprite/boss_symbol.animation = "mute"
			$card_sprite/boss_symbol2.animation = "mute"
			$card_sprite/boss_symbol.scale.x = MIMIC_SCALE
			$card_sprite/boss_symbol2.scale = MIMIC_SCALE
		"Thief Boss":
			$card_sprite/boss_symbol.animation = "thief"
			$card_sprite/boss_symbol2.animation = "thief"
			$card_sprite/boss_symbol.scale.x = THIEF_SCALE
			$card_sprite/boss_symbol2.scale = THIEF_SCALE
		"Final Boss":
			$card_sprite/boss_symbol.animation = "final_default"
			$card_sprite/boss_symbol.scale = THIEF_SCALE
			var sprite: String = FINAL_BOSS_SPRITES.pick_random()
			$card_sprite/boss_symbol2.animation = sprite
			if sprite == "final_thief":
				$card_sprite/boss_symbol2.scale = FINAL_THIEF_SCALE
			else:
				$card_sprite/boss_symbol2.scale = THIEF_SCALE
		_: #This line means default case
			print("Invalid bossName given to card.gd method setSprites()")
			

func _to_string() -> String:
	if rank in royalty:
		return "[Rank=%s, Suit=%s]" % [rank, suit]
	else:
		return "[Value=%d, Suit=%s]" % [value, suit]

func display_card():
	print("rank: " + rank + " value: " +str(value) + " suit: " + suit)
