extends Node2D

const ability = preload("res://Scenes/Ability.tscn")
const ABILITIES_FILE: String = "res://InformationFiles/AbilityInfo.txt";
const ABILITY_SPRITES_INIT_PATH: String = "res://Assets/Sprites/Abilities/"
const GUARANTEED_FIRST_ABILITY: int = 1
const ABILITIES_POSITION: Vector2 = Vector2(-1000,-1000)
const A_NUMS: Array[int] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
var a_available: Array[int] = A_NUMS.duplicate()
var a_dict: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AbilityObserver.ability_manager = self
	loadAllAbs()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#Function to build the dictionary of abilities
func add_To_Dict(key: String, value: Node2D) -> void:
	#The keys should be the names of the abilities and the values should be the corresponding ability scene
	a_dict[key] = value

# Function to load all of the abilities from their file into the ability dictionary
func loadAllAbs() -> void:
	for num in range(1,13):
		#print("Ability Number " + str(num))
		match num:
			#Each option should set the name, description, and active status of the ability
			1:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			2:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			3:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			4:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			5:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			6:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			7:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			8:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			9:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			10:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			11:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			12:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				buildAbility(details)
			_:
				print("Invalid number supplied to Abilities.loadAllAbs()")

#Function to create the selection of abilities to show the player after each level
func createSelection() -> void:
	var list: Array[Node2D] = []
	for num in getNums():
		match num:
			# Each option should retrieve the correct ability from the file
			# then it should call the selection node to display the correct info
			1:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Reroll"])
			2:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Clairvoyance"])
			3:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Stun"])
			4:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Gambler"])
			5:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Lucky Doubles"])
			6:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Cheapskate"])
			7:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Time Rewind"])
			8:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Joker"])
			9:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Ditto"])
			10:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Peeping Tom"])
			11:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Reversal"])
			12:
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				list.append(a_dict["Sleight Of Hand"])
			_:
				print("Invalid number supplied to Abilities.createSelection()")
	$Selection.setOptions(list)

# Function to create an ability for a player and add it to the dictionary
func buildAbility(details: Array[String]) -> void:
	var a_scene = ability.instantiate()
	fillAbility(details, a_scene)
	self.add_child(a_scene)
	var a_name: String = a_scene.getName()
	setAbilitySymbol(a_scene, a_name)
	a_scene.position = ABILITIES_POSITION
	add_To_Dict(a_name, a_scene)
	
# Function to get the numbers for the next abilities to be shown to the player
func getNums() -> Array[int]:
	var tempArray: Array[int] = []
	for i in range(3): ## This range value should be 3 normally ##
		var tempNum = a_available.pick_random()
		tempArray.append(tempNum)
		a_available.erase(tempNum)
	return tempArray

# Function to find a specific line in a file
func getLineFromFile(file_path: String, target: int) -> Array[String]:
	if(FileAccess.file_exists(file_path)):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var current_line = 0
		# Loop through the file until we find the right line
		while(file.get_position() < file.get_length()):
			var line: PackedStringArray = file.get_csv_line()
			# Once we find the right line, pull all of the attributes out and return them
			if current_line == (target):
				var abilityInfo: Array[String] = []
				for i in line.size():
					var attribute: String = line[i]
					#print(attribute)
					abilityInfo.append(attribute)
				file.close()
				return abilityInfo
			else:
				current_line += 1
	else:
		print("Ability information file could not be found")
	return []

#Function to set values of an ability based on an array of strings
func fillAbility(details: Array[String], ablty: Node2D) -> void:
	if details.size() > 0 && not details.size() > 4:
		ablty.setName(details[0])
		ablty.setDescription(details[1])
		ablty.setCooldown(details[2].to_int())
		ablty.setStatus(details[3])
	elif details.size() > 4:
		print("Too many arguments in ability attribute list")
	else:
		print("Empty ability attributes list")

#Function to set the new ability button skins
func setAbilitySymbol(ability_scene: Node2D, a_name: String) -> void:
	var a_path: String = ABILITY_SPRITES_INIT_PATH + a_name.to_lower().replace(" ", "_") + ".png"
	#print(a_path)
	ability_scene.setSkin(a_path)
