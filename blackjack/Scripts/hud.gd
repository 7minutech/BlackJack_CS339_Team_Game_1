extends Node2D

var passivesList: Array[PackedScene] = []
var activesList: Array[PackedScene] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	addAbilities()
	setActivesDescriptions()
	setPassivesDescription()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Function to get input information
func getInputMethod() -> void:
	pass
	
#Functions to get ability information from player
func getAbilityDescription(ablty: PackedScene) -> void:
	pass
func getAbilityTexture() -> void:
	pass

#Function to adjust displayed info based on current abilities
func setActivesDescriptions() -> void:
	for ablty in activesList:
		$Info_Active.append_text(ablty.getDescription() + "\n")
func setPassivesDescription() -> void:
	for ablty in activesList:
		$Info_Passive.append_text(ablty.getDescription() + "\n")

#Functions to store information about an added ability
func addAbilities() -> void:
	var ablty: Array[Node2D] = get_tree().current_scene.find_child("Player").getAbilities()
	var indexCounter: int = 0
	for a in ablty:
		if a.isActive():
			activesList.append(a)
		else:
			passivesList.append(a)
		match indexCounter:
			0:
				setDown(a.getSkin())
			1:
				setRight(a.getSkin())
			2:
				setLeft(a.getSkin())
			3:
				setUp(a.getSkin())
			_:
				print("Invalid value")
		indexCounter += 1

#Functions to assign an ability and a skin to a button
func setLeft(skin: CompressedTexture2D) -> void:
	$Button_Left/AbilitySymbol_Left.texture = skin
func setDown(skin: CompressedTexture2D) -> void:
	$Button_Down/AbilitySymbol_Down.texture = skin
func setRight(skin: CompressedTexture2D) -> void:
	$Button_Right/AbilitySymbol_Right.texture = skin
func setUp(skin: CompressedTexture2D) -> void:
	$Button_Up/AbilitySymbol_Up.texture = skin

#Function to set InputSymbol Sprite textures
func setInputType() -> void:
	pass

#Functions to trigger events when the buttons are pressed
## Ability Buttons
func _on_button_left_pressed() -> void:
	var ablty: Array[Node2D] = get_tree().current_scene.find_child("Player").getAbilities()
	SignalBus.left_pressed.emit(ablty[0].name)
	pass # Replace with function body.
func _on_button_down_pressed() -> void:
	var ablty: Array[Node2D] = get_tree().current_scene.find_child("Player").getAbilities()
	SignalBus.down_pressed.emit(ablty[0].name)
	pass # Replace with function body.
func _on_button_right_pressed() -> void:
	var ablty: Array[Node2D] = get_tree().current_scene.find_child("Player").getAbilities()
	SignalBus.right_pressed.emit(ablty[0].name)
	pass # Replace with function body.
func _on_button_up_pressed() -> void:
	var ablty: Array[Node2D] = get_tree().current_scene.find_child("Player").getAbilities()
	SignalBus.up_pressed.emit(ablty[0].name)
	pass # Replace with function body.
## Hit/Stand Buttons
func _on_hit_button_pressed() -> void:
	SignalBus.hit_pressed.emit()
	# Any other HUD-specific logic can still go here

func _on_stand_button_pressed() -> void:
	SignalBus.stand_pressed.emit()
