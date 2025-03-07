extends Node

var player_ability_names: Array[String]
var player_ability_scenes: Array[Node2D]
var player
var main
var ability_manager
var abilities_left 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func save_abilities():
	player_ability_names = player.ability_names
	player_ability_scenes = player.abilities
	abilities_left = ability_manager.a_available
	pass

func load_abilities():
	update_hud()
	update_abilites_left()
	pass

func update_hud():
	for ability_key in player_ability_names:
		main.give_ability(ability_key)
		
func update_abilites_left():
	if abilities_left != null:
		ability_manager.a_available = abilities_left
