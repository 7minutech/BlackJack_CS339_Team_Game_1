extends Node2D

var passivesList: Array[Node2D] = []
var activesList: Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#Function to get input information
func getInputMethod() -> void:
	pass
	
#Functions to get ability information from player
func getAbilityDescription(ablty: Node2D) -> void:
	pass
func getAbilityTexture() -> void:
	pass

#Function to adjust displayed info based on current abilities
func setActivesDescriptions() -> void:
	for ablty in activesList:
		$Info_Active.append_text(str(activesList.find(ablty) + 1) + ": " + ablty.getName() + "\n")
		$Info_Active.tooltip_text += str(activesList.find(ablty) + 1) + ": " + ablty.getDescription() + "\n"
func setPassivesDescriptions() -> void:
	for ablty in activesList:
		$Info_Passive.append_text(str(activesList.find(ablty) + 1) + ": " + ablty.getName() + "\n")
		$Info_Passive.tooltip_text += str(activesList.find(ablty) + 1) + ": " + ablty.getDescription() + "\n"

#Functions to store information about an added ability
func addAbilities(a_list: Array[Node2D]) -> void:
	var indexCounter: int = 0
	for a in a_list:
		if a.isActive():
			activesList.append(a)
			setActivesDescriptions()
		else:
			passivesList.append(a)
			setPassivesDescriptions()
		match indexCounter:
			0:
				$Button_Down.disabled = false
				setDown(a.getSkin())
			1:
				$Button_Right.disabled = false
				setRight(a.getSkin())
			2:
				$Button_Left.disabled = false
				setLeft(a.getSkin())
			3:
				$Button_Up.disabled = false
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
	var ablty: Array[Node2D] = activesList
	SignalBus.left_pressed.emit(ablty[2].name)
func _on_button_down_pressed() -> void:
	var ablty: Array[Node2D] = activesList
	SignalBus.down_pressed.emit(ablty[0].name)
func _on_button_right_pressed() -> void:
	var ablty: Array[Node2D] = activesList
	SignalBus.right_pressed.emit(ablty[1].name)
func _on_button_up_pressed() -> void:
	var ablty: Array[Node2D] = activesList
	SignalBus.up_pressed.emit(ablty[3].name)

## Hit/Stand Buttons
func _on_hit_button_pressed() -> void:
	SignalBus.hit_pressed.emit()
	# Any other HUD-specific logic can still go here
func _on_stand_button_pressed() -> void:
	SignalBus.stand_pressed.emit()


func _on_info_passive_focus_entered() -> void:
	$Info_Passive.get_menu()
