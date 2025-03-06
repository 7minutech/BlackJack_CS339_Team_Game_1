extends Node2D

var passivesList: Array[Node2D] = []
var activesList: Array[Node2D] = []
var numActive: int = 0
var numPassive: int = 0

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
	$Info_Active.clear()
	$Info_Active.tooltip_text = "Active Abilities Detailed:\n"
	$Info_Active.add_text("Active Abilities:\n")
	for ablty in activesList:
		$Info_Active.add_text("A" + str(activesList.find(ablty) + 1) + ": " + ablty.getName() + "\n")
		$Info_Active.tooltip_text += "A" + str(activesList.find(ablty) + 1) + ": " + ablty.getDescription() + "\n"
func setPassivesDescriptions() -> void:
	$Info_Passive.clear()
	$Info_Passive.tooltip_text = "Passive Abilities Detailed:\n"
	$Info_Passive.add_text("Passive Abilities:\n")
	for ablty in passivesList:
		$Info_Passive.add_text("P" + str(passivesList.find(ablty) + 1) + ": " + ablty.getName() + "\n")
		$Info_Passive.tooltip_text += "P" + str(passivesList.find(ablty) + 1) + ": " + ablty.getDescription() + "\n"

#Functions to store information about an added ability
func addAbilities(a_list: Array[Node2D]) -> void:
	for a in a_list:
		if a.isActive() and not activesList.has(a):
			activesList.append(a)
			setActivesDescriptions()
			numActive += 1
			match numActive:
				1:
					setDown(a.getSkin())
				2:
					setRight(a.getSkin())
				3:
					setLeft(a.getSkin())
				4:
					setUp(a.getSkin())
				_:
					print("Invalid value provided to numActive in HUD.addAbilities()")
		elif not a.isActive() and not passivesList.has(a):
			passivesList.append(a)
			setPassivesDescriptions()
			numPassive += 1
			match numPassive:
				1:
					$Passive_Abilities/AbilitySymbol_Passive1.texture = a.getSkin()
				2:
					$Passive_Abilities/AbilitySymbol_Passive2.texture = a.getSkin()
				3:
					$Passive_Abilities/AbilitySymbol_Passive3.texture = a.getSkin()
				4:
					$Passive_Abilities/AbilitySymbol_Passive4.texture = a.getSkin()
				_:
					print("Invalid value provided to numPassive in HUD.addAbilities()")

#Functions to assign an ability and a skin to a button
func setLeft(skin: CompressedTexture2D) -> void:
	$Button_Left.disabled = false
	$Button_Left/AbilitySymbol_Left.texture = skin
func setDown(skin: CompressedTexture2D) -> void:
	$Button_Down.disabled = false
	$Button_Down/AbilitySymbol_Down.texture = skin
func setRight(skin: CompressedTexture2D) -> void:
	$Button_Right.disabled = false
	$Button_Right/AbilitySymbol_Right.texture = skin
func setUp(skin: CompressedTexture2D) -> void:
	$Button_Up.disabled = false
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
