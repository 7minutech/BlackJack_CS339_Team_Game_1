extends Node2D

var abilitesList: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Functions to get ability information from player
func getAbilityDescription() -> void:
	pass
func getAbilityTexture() -> void:
	pass

#Function to get input information
func getInputMethod() -> void:
	pass

#Functions to adjust displayed info based on current abilities
func setActiveDescriptions() -> void:
	pass
func setPassiveDescriptions() -> void:
	pass

#Functions to assign an ability to a button
func setLeft() -> void:
	pass
func setDown() -> void:
	pass
func setRight() -> void:
	pass
func setUp() -> void:
	pass

#Function to set InputSymbol Sprite textures
func setInputType() -> void:
	pass

#Functions to trigger events when the buttons are pressed
func _on_button_left_pressed() -> void:
	pass # Replace with function body.
func _on_button_down_pressed() -> void:
	pass # Replace with function body.
func _on_button_right_pressed() -> void:
	pass # Replace with function body.
func _on_button_up_pressed() -> void:
	pass # Replace with function body.
