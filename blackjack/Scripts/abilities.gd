extends Node2D

const ability = preload("res://Scenes/Ability.tscn")
const ABILITIES_FILE: String = "res://InformationFiles/AbilityInfo.txt";
const A_NUMS: Array[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
var a_available: Array[int] = A_NUMS.duplicate()
var a_list: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Function to build the dictionary of abilities
func add_To_Dict(key: String, value: Node2D) -> void:
	#The keys should be the names of the abilities and the values should be the corresponding ability scene
	a_list[key] = value

func tesstSelection() -> void:
	for num in range(1,13):
		print("Ability Number " + str(num))
		match num:
			#Each option should set the name, description, and active status of the ability
			1:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			2:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			3:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			4:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			5:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			6:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			7:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			8:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			9:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			10:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			11:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			12:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			_:
				print("Invalid number supplied to Abilities.createSelection()")

	
#Function to create the selection of abilities to show the player after each level
func createSelection() -> void:
	for num in getNums():
		print("Ability Number " + str(num))
		match num:
			#Each option should set the name, description, and active status of the ability
			1:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
				add_To_Dict(a_scene.getName(), a_scene)
			2:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
			3:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
			4:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
			5:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
			6:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
			7:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
			8:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
			9:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
			10:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
			11:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
			12:
				var a_scene = ability.instantiate()
				var details: Array[String] = getLineFromFile(ABILITIES_FILE, num)
				fillAbility(details, a_scene)
				self.add_child(a_scene)
			_:
				print("Invalid number supplied to Abilities.createSelection()")
	
# Function to get the numbers for the next abilities to be shown to the player
func getNums() -> Array[int]:
	var tempArray: Array[int] = []
	tempArray.append(1) ## These two lines are only for testing and should be removed later ##
	a_available.erase(1) ##
	for i in range(2): ## This range value should be 3 normally ##
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
		print("File could not be found")
	return []

#Function to set values of an ability based on an array of strings
func fillAbility(details: Array[String], ability: Node2D) -> void:
	if details.size() > 0:
		ability.setName(details[0])
		ability.setDescription(details[1])
		ability.setCooldown(details[2].to_int())
		ability.setStatus(details[3])
	else:
		print("Empty attributes list")
