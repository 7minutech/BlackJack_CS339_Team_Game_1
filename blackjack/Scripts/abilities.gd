extends Node2D

const ability = preload("res://Scenes/Ability.tscn")
var a_list: Dictionary
const A_NUMS: Array[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
var a_available: Array[int] = A_NUMS.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Function to build the dictionary of abilities
func build_Dict() -> void:
	#The keys should be the names of the abilities and the values should be the corresponding ability scene
	pass
	
#Function to create the selction of abilities to show the player after each level
func createSelection() -> PackedScene:
	for num in getNums():
		var a_name: String
		var a_description: String
		var a_scene = ability.instantiate()
		self.add_child(a_scene)
		match num:
			#Each option should set the name, description, and active status of the ability
			1:
				pass
			2:
				pass
			3:
				pass
			4:
				pass
			5:
				pass
			6:
				pass
			7:
				pass
			8:
				pass
			9:
				pass
			10:
				pass
			11:
				pass
			12:
				pass
			_:
				print("Invalid number supplied to Abilities.createSelection()")
	return null
	
func getNums() -> Array[int]:
	var tempArray: Array[int] = []
	for i in range(3):
		var tempNum = a_available.pick_random()
		tempArray.append(tempNum)
		a_available.erase(tempNum)
	return tempArray
	
