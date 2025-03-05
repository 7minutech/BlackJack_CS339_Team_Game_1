extends Node2D

const SCREEN_WIDTH: int = 1152
const SCREEN_HEIGHT: int = 648
const BUTTON_X_COORDS: Array[float] = [6, 2.07, 1.25]
var bgArea: Rect2
var currentNums: Array[int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	placeButtons()
	hideOptions()
	#showOptions()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Function to properly position buttons on screen
func placeButtons() -> void:
	$Background.position = Vector2(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
	for i in BUTTON_X_COORDS:
		var button: Button = get_node("Option" + str(BUTTON_X_COORDS.find(i) + 1))
		var X: int = (SCREEN_WIDTH/i) * $Background.scale.x #6, 2, 1.3
		var Y: int = (SCREEN_HEIGHT/2.5) * $Background.scale.y
		button.position = Vector2(X, Y)

# Function to adjust the information displayed by the buttons
func setOptions(options: Array[Node2D]) -> void:
	var index: int = 0
	for option in options:
		index += 1
		get_node("Option" + str(index)).set_text(option.getName())
		get_node("Option" + str(index)).icon = option.getSkin()

# Functions to show and hide the menu
func showOptions() -> void:
	var d_hand = get_parent().get_parent().find_child("Dealer").hand
	var p_hand = get_parent().get_parent().find_child("Player").hand
	var deck = self.get_parent().get_parent().find_child("Dealer").find_child("Deck")
	print(deck)
	self.get_parent().get_parent().find_child("HUD").hide()
	self.show()
	for child in self.get_children():
		if child is Button:
			child.disabled = false

func hideOptions() -> void:
	self.hide()
	for child in self.get_children():
		if child is Button:
			child.disabled = true
			
# Functions to handle button presses
func _on_option_1_pressed() -> void:
	self.get_parent().get_parent().give_ability($Option1.get_text())
func _on_option_2_pressed() -> void:
	self.get_parent().get_parent().give_ability($Option2.get_text())
func _on_option_3_pressed() -> void:
	self.get_parent().get_parent().give_ability($Option3.get_text())
