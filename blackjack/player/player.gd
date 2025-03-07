extends Node

const WIN_VAL = 1
var hand: Array[Node2D] = []
var hand_2: Array[Node2D] = []
var abilities: Array[Node2D] = []
var ability_names: Array[String] = []
#var abs = []
#var abs_names = []
var chips = 0
var total_card_value = 0
var selected_cards = []
var bust = false
var standing = false
var is_split = false
var has_reroll = false
var stun_timer = 1

# Called Swhen the node enters the scene tree for the first time.
func _ready() -> void:
	AbilityObserver.player = self  
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func value_ace():
	for card in hand:
		if card.rank == "ace":
			sum_card_value()
			if total_card_value > 21:
				card.value = 1
	sum_card_value()

func win_chip() -> void:
	chips += 1

# Dealer loses a chip
func lose_chip() -> void:
	chips -= 1

func clear_hand():
	hand.clear()
	
func hit(card: Node2D):
	var deck = get_parent().get_node("Dealer/Deck")
	if not bust: 
		hand.append(card)
		get_parent().find_child("HUD").find_child("Hands").addCardToPlayerHand(card)
	
func clear_selected_cards():
	selected_cards = []
	
func has_bust():
	sum_card_value()
	if total_card_value > 21:
		bust = true
	else:
		bust = false


func is_standing():
	if standing:
		return true
	return false
	
func split(card_1,card_2):
	if can_split_cards(card_1, card_2):
		var index = hand.find(card_2)
		hand_2.append(hand.pop_at(index))	
		is_split = true
	return
func can_split_cards(card_1,card_2):
	if card_1.value == card_2.value && card_1.rank == card_2.rank && selected_cards.length == 2:
		return true
	return false
	
func sum_card_value():
	total_card_value = 0
	for card in hand:
		total_card_value += card.value

func stand():
	standing = true
	#total_card_value
	
func has_won():
	if chips >= WIN_VAL:
		return true
	return false

func round_reset():
	bust = false

#Functions to add an ability; get the list of abilities; and check for specific abilities
func addAbility(ability: Node2D) -> void:
	abilities.append(ability)
	ability_names.append(ability.name)
	get_parent().find_child("HUD").addAbilities(abilities)
func getAbilities() -> Array[Node2D]:
	return abilities
func has_ability(a_name: String) -> bool:
	return ability_names.has(a_name)

func show_hand():
	for card in hand:
		print(card)

func hand_str() -> String:
	var card_str = ""
	for card in hand:
		card_str += card._to_string()
	card_str += " Value: " + str(total_card_value)
	return card_str

func can_stun():
	print("Stun timer: " + str(stun_timer))
	return ability_names.has("Stun") and stun_timer % 3 == 0
	
func display_abilities():
	for ability in ability_names:
		print(ability)

func reset_abilites():
	abilities = []
	ability_names = []
	
